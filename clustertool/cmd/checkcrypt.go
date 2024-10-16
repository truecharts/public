package cmd

import (
	"os"

	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/sops"
)

var checkcrypt = &cobra.Command{
	Use:   "checkcrypt",
	Short: "Checks if all files are encrypted correctly in accordance with .sops.yaml",
	Run: func(cmd *cobra.Command, args []string) {
		if err := sops.CheckFilesAndReportEncryption(false, false); err != nil {
			log.Info().Msgf("Error checking files: %v\n", err)
			os.Exit(1)
		}
	},
}

func init() {
	RootCmd.AddCommand(checkcrypt)
}
