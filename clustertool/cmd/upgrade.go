package cmd

import (
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/gencmd"
	"github.com/truecharts/private/clustertool/pkg/helper"
	"github.com/truecharts/private/clustertool/pkg/sops"
)

var upgrade = &cobra.Command{
	Use:   "upgrade",
	Short: "Upgrade Talos Nodes and Kubernetes",
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
