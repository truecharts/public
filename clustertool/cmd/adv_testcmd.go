package cmd

import (
    "context"
    "os"
    "path/filepath"
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
    "github.com/truecharts/public/clustertool/pkg/kubectlcmds"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

var advTestCmdlongHelp = strings.TrimSpace(`
This command is mostly just for development usage and should NEVER be used by end-users.
`)

var testcmd = &cobra.Command{
    Use:   "test",
    Short: "tests specific code for developer usages",
    Long:  advTestCmdlongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        ctx := context.Background()
        initfiles.LoadTalEnv(false)
        talassist.LoadTalConfig()
        // err := fluxhandler.ProcessJSONFiles("./testdata/truenas_exports")
        // if err != nil {
        //  log.Info().Msg("Error:", err)
        // }
        var manifestPaths = []string{
            filepath.Join(helper.KubernetesPath, "flux-system", "flux", "sopssecret.secret.yaml"),
            filepath.Join(helper.KubernetesPath, "flux-system", "flux", "deploykey.secret.yaml"),
            filepath.Join(helper.KubernetesPath, "flux-system", "flux", "clustersettings.secret.yaml"),
        }
        for _, filePath := range manifestPaths {
            log.Info().Msgf("Bootstrap: Loading Manifest: %v", filePath)
            if err := kubectlcmds.KubectlApply(ctx, filePath); err != nil {
                log.Info().Msgf("Error applying manifest for %s: %v\n", filepath.Base(filePath), err)
                os.Exit(1)
            }
        }
    },
}

func init() {
    adv.AddCommand(testcmd)
}
