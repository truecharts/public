package cmd

import (
	"strings"

	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/gencmd"
	"github.com/truecharts/private/clustertool/pkg/helper"
	"github.com/truecharts/private/clustertool/pkg/nodestatus"
	"github.com/truecharts/private/clustertool/pkg/sops"
)

var genConfigLongHelp = strings.TrimSpace(`
ClusterTool after all your settings are entered into talconfig.yaml and talenv.yaml, Clustertool generates a complete clusterconfiguration using TalHelper and various other tools.

Its important to note, that running clustertool genconfig, again after each settings change, is absolutely imperative to be able to deploy said settings to your cluster.

Powered by TalHelper (https://budimanjojo.github.io/talhelper/)

`)

var genConfig = &cobra.Command{
	Use:     "genconfig",
	Short:   "generate Configuration files",
	Long:    genConfigLongHelp,
	Example: "clustertool genconfig",
	Run: func(cmd *cobra.Command, args []string) {
		if err := sops.DecryptFiles(); err != nil {
			log.Info().Msgf("Error decrypting files: %v\n", err)
		}

		gencmd.GenConfig(args)
		err := nodestatus.CheckHealth(helper.TalEnv["VIP_IP"], "", true)
		if err == nil {
			log.Info().Msg("Running Cluster Detected, setting KubeConfig...")
			kubeconfigcmds := gencmd.GenKubeConfig(helper.TalEnv["VIP_IP"])
			gencmd.ExecCmd(kubeconfigcmds)
		} else {
			log.Info().Msg("No Running Cluster Detected, Skipping KubeConfig...")
		}
	},
}

func init() {
	RootCmd.AddCommand(genConfig)
}
