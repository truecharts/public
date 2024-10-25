package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/gencmd"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var advResetLongHelp = strings.TrimSpace(`

`)

var reset = &cobra.Command{
    Use:     "reset",
    Short:   "Reset Talos Nodes and Kubernetes",
    Example: "clustertool adv reset <NodeIP>",
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

        log.Info().Msg("Running Cluster node Reset")

        taloscmds := gencmd.GenReset(node, extraArgs)
        gencmd.ExecCmds(taloscmds, true)

    },
}

func init() {
    adv.AddCommand(reset)
}
