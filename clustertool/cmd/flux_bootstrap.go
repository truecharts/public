package cmd

import (
    "context"
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/fluxhandler"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var fluxBootstrapLongHelp = strings.TrimSpace(`

`)

var fluxbootstrap = &cobra.Command{
    Use:     "bootstrap",
    Short:   "Manually bootstrap fluxcd on existing cluster",
    Example: "clustertool flux bootstrap",
    Long:    fluxBootstrapLongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        ctx := context.Background()

        if err := sops.DecryptFiles(); err != nil {
            log.Info().Msgf("Error decrypting files: %v\n", err)
        }
        initfiles.LoadTalEnv(false)
        fluxhandler.FluxBootstrap(ctx)
    },
}

func init() {
    fluxCmd.AddCommand(fluxbootstrap)
}
