package cmd

import (
	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/sops"
)

var encrypt = &cobra.Command{
	Use:   "encrypt",
	Short: "Encrypt all high-risk data using sops",
	Run: func(cmd *cobra.Command, args []string) {
		if err := sops.EncryptAllFiles(); err != nil {
			log.Info().Msgf("Error encrypting files: %v\n", err)
		}
	},
}

func init() {
	RootCmd.AddCommand(encrypt)
}
