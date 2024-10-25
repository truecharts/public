package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var decryptLongHelp = strings.TrimSpace(`
The decryption feature of ClusterTool goes over all config files and, if encrypted, checks if ".sops.yaml" specifies that they should be decrypted.
If so, they are decrypted using your "age.agekey" file as specified in ".sops.yaml".

`)

var decrypt = &cobra.Command{
    Use:     "decrypt",
    Short:   "Decrypt all high-risk data using sops",
    Example: "clustertool decrypt",
    Long:    decryptLongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        if err := sops.DecryptFiles(); err != nil {
            log.Info().Msgf("Error decrypting files: %v\n", err)
        }
    },
}

func init() {
    RootCmd.AddCommand(decrypt)
}
