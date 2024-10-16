package cmd

import (
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/sops"
)

var decrypt = &cobra.Command{
	Use:   "decrypt",
	Short: "Decrypt all high-risk data using sops",
	Run: func(cmd *cobra.Command, args []string) {
		if err := sops.DecryptFiles(); err != nil {
			log.Info().Msgf("Error decrypting files: %v\n", err)
		}
	},
}

func init() {
	RootCmd.AddCommand(decrypt)
}
