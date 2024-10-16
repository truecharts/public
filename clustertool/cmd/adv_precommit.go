package cmd

import (
	"os"

	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/sops"
)

var precommit = &cobra.Command{
	Use:   "precommit",
	Short: "Runs the PreCommit encryption check",
	Run: func(cmd *cobra.Command, args []string) {
		if err := sops.CheckFilesAndReportEncryption(true, true); err != nil {
			log.Info().Msgf("Error checking files: %v\n", err)
			os.Exit(1)
		}
	},
}

func init() {
	adv.AddCommand(precommit)
}
