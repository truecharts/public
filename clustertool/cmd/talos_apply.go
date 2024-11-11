package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/gencmd"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
    "github.com/truecharts/public/clustertool/pkg/nodestatus"
    "github.com/truecharts/public/clustertool/pkg/sops"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

var applyLongHelp = strings.TrimSpace(`
The "apply" command applies your Talos System configuration to each node in the cluster, existing or new It also runs automated checking of your config file and health checks between each node it has processed, to ensure you don't accidentally take down your whole cluster.

## Bootstrapping
If the cluster has not been bootstrapped yet, Apply will automatically detect this and ask if you want to bootstrap the cluster

Bootstrapping will apply your config to the first (top) controlplane node in your "talconfig.yaml", it then "bootstraps" hence creating a new cluster with said node.

After this is done, we apply a number of helm-charts and manifests by default such as:

- Metallb
- Metallb-Config
- Cilium (CNI)
- Certificate-Approver
- Spegel
- Kubernetes-Dashboard

### Bootstrapping FluxCD

During Bootstrapping, if a "GITHUB_REPOSITORY" is set in "clusterenv.yaml", you will be asked if you also want to bootstrap FluxCD, checkout the getting-started guide for more info

## About Bootstrapping

While we load a lot of helm-charts during bootstrap, we will *never* manage them for you.
You're responsible for maintaining and configuring your cluster after bootstrapping.

Apply and *all other* commands, are just for maintaining Talos itself.
Not any contained helm-charts

`)

var apply = &cobra.Command{
    Use:     "apply",
    Short:   "apply",
    Aliases: []string{"apply-config"},
    Example: "clustertool apply <NodeIP>",
    Long:    applyLongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        var extraArgs []string
        node := ""

        if len(args) > 1 {
            extraArgs = args[1:]
        }
        if len(args) >= 1 {
            node = args[0]
            if args[0] == "all" {
                node = ""
            }
        }

        if err := sops.DecryptFiles(); err != nil {
            log.Info().Msgf("Error decrypting files: %v\n", err)
        }

        initfiles.LoadTalEnv(false)
        talassist.LoadTalConfig()
        bootstrapNode := talassist.TalConfig.Nodes[0].IPAddress

        log.Info().Msgf("Checking if first node   is ready to recieve anything... %s", bootstrapNode)
        status, err := nodestatus.WaitForHealth(bootstrapNode, []string{"running", "maintenance"})
        if err != nil {

        } else if status == "maintenance" {
            bootstrapNeeded, err := nodestatus.CheckNeedBootstrap(bootstrapNode)
            if err != nil {

            } else if bootstrapNeeded {
                log.Info().Msg("First Node requires to be bootstrapped before it can be used.")
                if helper.GetYesOrNo("Do you want to bootstrap now? (yes/no) [y/n]: ") {
                    gencmd.RunBootstrap(extraArgs)
                    if helper.GetYesOrNo("Do you want to apply config to all remaining clusternodes as well? (yes/no) [y/n]: ") {
                        RunApply(false, "", extraArgs)
                    }
                } else {
                    log.Info().Msg("Exiting bootstrap, as apply is not possible...")
                }

            } else {
                log.Info().Msg("Detected maintenance mode, but first node does not require to be bootrapped.")
                log.Info().Msg("Assuming apply is requested... continuing with Apply...")
                RunApply(true, node, extraArgs)
            }

        } else if status == "running" {
            log.Info().Msg("Apply: running first controlnode detected, continuing...")
            RunApply(true, node, extraArgs)
        }
    },
}

func RunApply(kubeconfig bool, node string, extraArgs []string) {
    taloscmds := gencmd.GenApply(node, extraArgs)
    gencmd.ExecCmds(taloscmds, true)

    if kubeconfig {
        kubeconfigcmds := gencmd.GenPlain("kubeconfig", helper.TalEnv["VIP_IP"], []string{"-f"})
        gencmd.ExecCmd(kubeconfigcmds[0])
    }

    //if helper.GetYesOrNo("Do you want to (re)load ssh, Sops and ClusterEnv onto the cluster? (yes/no) [y/n]: ") {
    //
    //}
}

func init() {
    talosCmd.AddCommand(apply)
}
