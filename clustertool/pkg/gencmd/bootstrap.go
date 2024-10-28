package gencmd

import (
    "context"
    "io"
    "os"
    "path/filepath"
    "strings"

    "github.com/rs/zerolog/log"

    talhelperCfg "github.com/budimanjojo/talhelper/v3/pkg/config"
    "github.com/budimanjojo/talhelper/v3/pkg/generate"
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/fluxhandler"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/kubectlcmds"
    "github.com/truecharts/public/clustertool/pkg/nodestatus"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var HelmRepos map[string]*fluxhandler.HelmRepo

var manifestPaths = []string{
    filepath.Join(helper.KubernetesPath, "flux-system", "flux", "sopssecret.secret.yaml"),
    filepath.Join(helper.KubernetesPath, "flux-system", "flux", "deploykey.secret.yaml"),
    filepath.Join(helper.KubernetesPath, "flux-system", "flux", "clustersettings.secret.yaml"),
}

func GenBootstrap(node string, extraFlags []string) string {
    cfg, err := talhelperCfg.LoadAndValidateFromFile(helper.TalConfigFile, []string{helper.ClusterEnvFile}, false)
    if err != nil {
        log.Fatal().Err(err).Msg("failed to parse talconfig or talenv file: %s")
    }

    applyStdout := os.Stdout
    r, w, _ := os.Pipe()
    os.Stdout = w

    err = generate.GenerateBootstrapCommand(cfg, helper.TalosGenerated, node, extraFlags)

    w.Close()
    out, _ := io.ReadAll(r)
    os.Stdout = applyStdout

    talosPath := embed.GetTalosExec()
    strout := strings.ReplaceAll(string(out), "talosctl", talosPath)
    strout = strings.ReplaceAll(strout, "\n", "")
    strout = strings.ReplaceAll(strout, ";", "")

    if err != nil {
        log.Fatal().Err(err).Msg("failed to generate talosctl bootstrap command: %s")
    }
    return strout
}

func RunBootstrap(args []string) {
    var extraArgs []string
    if len(args) > 1 {
        extraArgs = args[1:]
    }
    if err := sops.DecryptFiles(); err != nil {
        log.Info().Msgf("Error decrypting files: %v\n", err)
    }

    bootstrapcmds := GenBootstrap("", extraArgs)
    bootstrapNode := helper.ExtractNode(bootstrapcmds)

    nodestatus.WaitForHealth(bootstrapNode, []string{"maintenance"})

    taloscmds := GenApply(bootstrapNode, extraArgs)
    ExecCmds(taloscmds, false)

    nodestatus.WaitForHealth(bootstrapNode, []string{"booting"})

    log.Info().Msgf("Bootstrap: At this point your system is installed to disk, please make sure not to reboot into the installer ISO/USB  %s", bootstrapNode)

    log.Info().Msgf("Bootstrap: running bootstrap on node:  %s", bootstrapNode)
    ExecCmd(bootstrapcmds)

    log.Info().Msgf("Bootstrap: waiting for VIP %v to come online...", helper.TalEnv["VIP_IP"])
    nodestatus.WaitForHealth(helper.TalEnv["VIP_IP"], []string{"running"})

    log.Info().Msgf("Bootstrap: Configuring kubectl for VIP: %v", helper.TalEnv["VIP_IP"])
    // Ensure kubeconfig is loaded
    kubeconfigcmds := GenKubeConfig(helper.TalEnv["VIP_IP"])
    ExecCmd(kubeconfigcmds)

    // Desired pod names
    requiredPods := []string{
        "kube-controller-manager",
        "kube-scheduler",
        "kube-apiserver",
    }

    log.Info().Msgf("Bootstrap: Waiting for system Pods to be running for: %v", helper.TalEnv["VIP_IP"])
    if err := kubectlcmds.CheckStatus(requiredPods, []string{}, 600); err != nil {
        log.Error().Err(err).Msgf("Error: %v\n", err)

        os.Exit(1)
    }

    log.Info().Msg("Bootstrap: Starting Cluster configuration...")
    // Start process to approve any cert requests till our manifests are loaded
    // Set up a signal handler to handle termination gracefully
    stopCh := make(chan struct{})

    // Get Kubernetes clientset
    clientset, err := kubectlcmds.GetClientset()
    if err != nil {
        log.Info().Msgf("Error getting Kubernetes clientset: %v", err)
        return
    }
    ctx := context.Background()

    helmRepoPath := filepath.Join("./repositories", "helm")
    HelmRepos, err = fluxhandler.LoadAllHelmRepos(helmRepoPath)

    // Call ApprovePendingCertificates with clientset and stopCh
    go kubectlcmds.ApprovePendingCertificates(clientset, stopCh)

    baseCharts := []fluxhandler.HelmChart{
        // Pulled directly from upstream, due to this being very complex and important
        {filepath.Join(helper.ClusterPath, "/kubernetes/kube-system/cilium/app"), false, true},
        {filepath.Join(helper.ClusterPath, "/kubernetes/kube-system/kubelet-csr-approver/app"), false, true},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/traefik-crds/app"), false, false},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/prometheus-operator/app"), false, false},
    }

    fluxhandler.InstallCharts(baseCharts, HelmRepos, true)

    log.Info().Msg("Bootstrap: Creating Namespaces...")

    var namespaceFilePaths []string
    var VSCfilePaths []string

    // Walk through the directory recursively and find all namespace.yaml files
    err = filepath.WalkDir(helper.ClusterPath, func(path string, d os.DirEntry, err error) error {
        if err != nil {
            return err
        }
        if d.IsDir() {
            return nil
        }
        if filepath.Base(path) == "namespace.yaml" {
            namespaceFilePaths = append(namespaceFilePaths, path)
        }
        if filepath.Base(path) == "volumeSnapshotClass.yaml" {
            VSCfilePaths = append(VSCfilePaths, path)
        }
        return nil
    })

    if err != nil {
        log.Info().Msgf("Error walking the path: %v\n", err)
        return
    }

    for _, filePath := range namespaceFilePaths {
        log.Info().Msgf("Bootstrap: Loading namespace: %v", filePath)
        if err := kubectlcmds.KubectlApply(ctx, filePath); err != nil {
            log.Info().Msgf("Error applying manifest for %s: %v\n", filepath.Base(filePath), err)
            os.Exit(1)
        }
    }

    for _, filePath := range manifestPaths {
        log.Info().Msgf("Bootstrap: Loading Manifest: %v", filePath)
        if err := kubectlcmds.KubectlApply(ctx, filePath); err != nil {
            log.Info().Msgf("Error applying manifest for %s: %v\n", filepath.Base(filePath), err)
            os.Exit(1)
        }
    }

    log.Info().Msg("Bootstrap: Base Cluster Configuration Completed, continuing setup...")
    log.Info().Msg("Bootstrap: Confirming cluster health...")
    healthcmd := GenHealth(helper.TalEnv["VIP_IP"])
    ExecCmd(healthcmd)
    close(stopCh)

    prioCharts := []fluxhandler.HelmChart{
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/spegel/app"), false, true},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/cert-manager/app"), false, false},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/kyverno/app"), false, false},
    }
    fluxhandler.InstallCharts(prioCharts, HelmRepos, false)

    intermediateCharts := []fluxhandler.HelmChart{
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/metallb/app"), false, false},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/cloudnative-pg/app"), false, false},
        {filepath.Join(helper.ClusterPath, "/kubernetes/kube-system/node-feature-discovery/app"), false, false},
        {filepath.Join(helper.ClusterPath, "/kubernetes/kube-system/metrics-server/app"), false, false},
        {filepath.Join(helper.ClusterPath, "/kubernetes/kube-system/descheduler/app"), false, false},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/kubernetes-reflector/app"), false, false},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/volsync/app"), false, true},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/snapshot-controller/app"), false, true},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/openebs/app"), false, true},
        {filepath.Join(helper.ClusterPath, "/kubernetes/system/longhorn/app"), false, true},
    }

    fluxhandler.InstallCharts(intermediateCharts, HelmRepos, true)

    // Desired pod names
    requiredMLBPods := []string{
        "metallb-controller",
        "metallb-speaker",
    }

    log.Info().Msgf("Bootstrap: Waiting for MetalLB Pods to be running for: %v", helper.TalEnv["VIP_IP"])
    if err := kubectlcmds.CheckStatus(requiredMLBPods, []string{}, 600); err != nil {
        log.Error().Err(err).Msgf("Error: %v\n", err)

        os.Exit(1)
    }

    lateCharts := []fluxhandler.HelmChart{
        {filepath.Join(helper.ClusterPath, "/kubernetes/core/metallb-config/app"), false, false},
    }

    log.Info().Msgf("Bootstrap: Loading VolumeSnapshotClasses")

    for _, filePath := range VSCfilePaths {
        log.Info().Msgf("Bootstrap: Loading VolumeSnapshotClass: %v", filePath)
        if err := kubectlcmds.KubectlApply(ctx, filePath); err != nil {
            log.Info().Msgf("Error applying manifest for %s: %v\n", filepath.Base(filePath), err)
            os.Exit(1)
        }
    }

    fluxhandler.InstallCharts(lateCharts, HelmRepos, true)

    log.Info().Msg("Bootstrap: Installing included applications")
    postCharts := []fluxhandler.HelmChart{
        {filepath.Join(helper.ClusterPath, "/kubernetes/apps/kubernetes-dashboard/app"), false, true},
    }

    fluxhandler.InstallCharts(postCharts, HelmRepos, true)

    log.Info().Msg("------")

    fluxhandler.FluxBootstrap(ctx)

    log.Info().Msg("Bootstrap: Completed Successfully!")
}
