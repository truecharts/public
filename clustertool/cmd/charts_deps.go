package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/charts/deps"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

var chartsDepsLongHelp = strings.TrimSpace(`

`)

var depsCmd = &cobra.Command{
    Use:     "deps",
    Short:   "Download, Update and Verify Helm dependencies",
    Long:    chartsDepsLongHelp,
    Example: "clustertool charts deps <chart> <chart> <chart>",
    Run: func(cmd *cobra.Command, args []string) {
        if err := deps.LoadGPGKey(); err != nil {
            log.Fatal().Err(err).Msg("failed to load gpg key")
        }

        // Specify the mode (SyncMode or AsyncMode)
        mode := helper.SyncMode // Change to helper.SyncMode for synchronous processing
        if err := helper.WalkCharts(args, deps.DownloadDeps, "", mode); err != nil {
            log.Fatal().Err(err).Msg("failed to update Chart.yaml")
        }
    },
}

func init() {
    charts.AddCommand(depsCmd)
}
