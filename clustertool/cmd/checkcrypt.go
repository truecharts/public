package cmd

import (
    "os"
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var checkcyptLongHelp = strings.TrimSpace(`
It's imperative that you always ensure the config you send to the internet is thoroughly encrypted. Using "clustertool checkcrypt" you can easily check if all files that are due to being encrypted, as specified in ".sops.yaml", will actually be encrypted.

This tool can, for example, be used as a pre-commit check and will fail with a non-zero exit code if unencrypted files are detected that should've been encrypted in accordance with ".sops.yaml" configuration.

`)

var checkcrypt = &cobra.Command{
    Use:     "checkcrypt",
    Short:   "Checks if all files are encrypted correctly in accordance with .sops.yaml",
    Aliases: []string{"checkencrypt"},
    Example: "clustertool checkcrypt",
    Long:    checkcyptLongHelp,
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
