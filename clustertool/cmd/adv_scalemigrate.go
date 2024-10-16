package cmd

import (
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/scale"
)

var scalemigrate = &cobra.Command{
	Use:   "scalemigrate",
	Short: "Migrate exported SCALE Apps to the Talos Cluster",
	Run: func(cmd *cobra.Command, args []string) {
		err := scale.ProcessJSONFiles("./truenas_exports")
		if err != nil {
			log.Info().Msgf("Error: %v", err)
		}
	},
}

func init() {
	adv.AddCommand(scalemigrate)
}
