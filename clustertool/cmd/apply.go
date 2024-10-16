package cmd

import (
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/gencmd"
	"github.com/truecharts/private/clustertool/pkg/helper"
	"github.com/truecharts/private/clustertool/pkg/nodestatus"
	"github.com/truecharts/private/clustertool/pkg/sops"
)

var apply = &cobra.Command{
	Use:   "apply",
	Short: "apply TalosConfig",
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

		bootstrapcmds := gencmd.GenBootstrap("", extraArgs)
		bootstrapNode := helper.ExtractNode(bootstrapcmds)

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
						RunApply("", extraArgs)
					}
				} else {
					log.Info().Msg("Exiting bootstrap, as apply is not possible...")
				}

			} else {
				log.Info().Msg("Detected maintenance mode, but first node does not require to be bootrapped.")
				log.Info().Msg("Assuming apply is requested... continuing with Apply...")
				RunApply(node, extraArgs)
			}

		} else if status == "running" {
			log.Info().Msg("Apply: running first controlnode detected, continuing...")
			RunApply(node, extraArgs)
		}
	},
}

func RunApply(node string, extraArgs []string) {
	taloscmds := gencmd.GenApply(node, extraArgs)
	gencmd.ExecCmds(taloscmds, true)

	kubeconfigcmds := gencmd.GenKubeConfig(helper.TalEnv["VIP_IP"])
	gencmd.ExecCmd(kubeconfigcmds)
}

func init() {
	RootCmd.AddCommand(apply)
}
