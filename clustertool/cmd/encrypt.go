package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var encryptLongHelp = strings.TrimSpace(`
The encryption feature of ClusterTool goes over all config files and, if not encrypted already, checks if ".sops.yaml" mandates that they should be encrypted.
Afterwards, they are encrypted using your "age.agekey" file as specified in ".sops.yaml".

`)

var encrypt = &cobra.Command{
    Use:     "encrypt",
    Short:   "Encrypt all high-risk data using sops",
    Example: "clustertool encrypt",
    Long:    encryptLongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        if err := sops.EncryptAllFiles(); err != nil {
            log.Info().Msgf("Error encrypting files: %v\n", err)
        }
    },
}

func init() {
    RootCmd.AddCommand(encrypt)
}
