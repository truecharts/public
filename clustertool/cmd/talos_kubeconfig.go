package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/gencmd"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
    "github.com/truecharts/public/clustertool/pkg/sops"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

var advKubeconfigLongHelp = strings.TrimSpace(`

`)

var kubeconfig = &cobra.Command{
    Use:     "kubeconfig",
    Short:   "kubeconfig for Talos Cluster",
    Example: "clustertool talos kubeconfig <NodeIP>",
    Long:    advResetLongHelp,
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
        log.Info().Msg("Running Cluster kubeconfig")

        taloscmds := gencmd.GenPlain("kubeconfig", node, extraArgs)
        gencmd.ExecCmds(taloscmds, true)

    },
}

func init() {
    talosCmd.AddCommand(kubeconfig)
}
