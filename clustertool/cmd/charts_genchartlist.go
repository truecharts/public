package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/charts/website"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

var chartsGenChartsListLongHelp = strings.TrimSpace(`

`)

var genChartListCmd = &cobra.Command{
    Use:     "genchartlist",
    Short:   "Generate chart list json file",
    Long:    chartsGenChartsListLongHelp,
    Example: "clustertool charts genchartlist <path to charts folder>",
    Run: func(cmd *cobra.Command, args []string) {
        opts := &website.ChartListOptions{
            OutputPath:  "./charts.json",
            TrainFilter: []string{}, // We can filter by train later if needed
        }

        if err := helper.WalkCharts2(args, opts.GetChartData, helper.AsyncMode); err != nil {
            log.Fatal().Err(err).Msg("failed to generate chart list json file:")
        }

        if err := opts.WriteChartList(); err != nil {
            log.Fatal().Err(err).Msg("failed to write chart list json file:")
        }

    },
}

func init() {
    charts.AddCommand(genChartListCmd)
}
