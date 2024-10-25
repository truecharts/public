package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"

    "slices"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/charts/chartFile"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

var chartsGenMetaLongHelp = strings.TrimSpace(`

`)

var genMetaCmd = &cobra.Command{
    Use:     "genmeta",
    Short:   "Generate and update Chart.yaml metadata",
    Example: "clustertool charts genmeta",
    Long:    chartsGenMetaLongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        bump := ""
        if len(args) > 0 && slices.Contains([]string{"patch", "minor", "major"}, args[0]) {
            bump = args[0]
            args = args[1:]
        }

        // Specify the mode (SyncMode or AsyncMode)
        // Async Mode showed concurrency issues (Stavros)
        mode := helper.SyncMode

        err := helper.WalkCharts(args, chartFile.UpdateChartFile, bump, mode)
        if err != nil {
            log.Fatal().Err(err).Msg("failed to update Chart.yaml:")
        }
    },
}

func init() {
    charts.AddCommand(genMetaCmd)
}
