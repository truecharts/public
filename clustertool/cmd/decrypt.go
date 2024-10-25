package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var decryptLongHelp = strings.TrimSpace(`

`)

var decrypt = &cobra.Command{
    Use:   "decrypt",
    Short: "Decrypt all high-risk data using sops",
    Long:  decryptLongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        if err := sops.DecryptFiles(); err != nil {
            log.Info().Msgf("Error decrypting files: %v\n", err)
        }
    },
}

func init() {
    RootCmd.AddCommand(decrypt)
}
