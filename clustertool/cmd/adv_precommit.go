package cmd

import (
    "os"
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var advPrecommitLongHelp = strings.TrimSpace(`

`)

var precommit = &cobra.Command{
    Use:     "precommit",
    Short:   "Runs the PreCommit encryption check",
    Example: "clustertool adv precommit",
    Long:    advPrecommitLongHelp,
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
