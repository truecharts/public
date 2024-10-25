package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/gencmd"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var upgradeLongHelp = strings.TrimSpace(`
The "upgrade" command updates Talos to the latest version specified in talconfig.yaml for all nodes.
It also applies any changed "extentions" and/or "overlays" specified there.

On top of this, after upgrading Talos on all nodes, it also executes kubernetes-upgrades for the whole cluster as well.

`)

var upgrade = &cobra.Command{
    Use:     "upgrade",
    Short:   "Upgrade Talos Nodes and Kubernetes",
    Example: "clustertool upgrade <NodeIP>",
    Long:    upgradeLongHelp,
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

        log.Info().Msg("Running Cluster Upgrade")

        taloscmds := gencmd.GenUpgrade(node, extraArgs)
        gencmd.ExecCmds(taloscmds, true)

        log.Info().Msg("Running Kubernetes Upgrade")
        kubeUpgradeCmd := gencmd.GenKubeUpgrade(helper.TalEnv["VIP_IP"])
        gencmd.ExecCmd(kubeUpgradeCmd)

        log.Info().Msg("(re)Loading KubeConfig)")
        kubeconfigcmds := gencmd.GenKubeConfig(helper.TalEnv["VIP_IP"])
        gencmd.ExecCmd(kubeconfigcmds)

    },
}

func init() {
    RootCmd.AddCommand(upgrade)
}
