package cmd

import (
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/gencmd"
	"github.com/truecharts/private/clustertool/pkg/initfiles"
)

var testcmd = &cobra.Command{
	Use:   "test",
	Short: "test run",
	Run: func(cmd *cobra.Command, args []string) {
		initfiles.LoadTalEnv()
		// err := fluxhandler.ProcessJSONFiles("./testdata/truenas_exports")
		// if err != nil {
		// 	log.Info().Msg("Error:", err)
		// }
		something := gencmd.GenBootstrap("", []string{})
		log.Info().Msgf("test %v", something)
	},
}

func init() {
	adv.AddCommand(testcmd)
}
