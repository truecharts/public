package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/charts/version"
)

var chartsBumpLongHelp = strings.TrimSpace(`

`)

var bumper = &cobra.Command{
    Use:     "bump",
    Short:   "generate a bumped image version",
    Long:    chartsBumpLongHelp,
    Example: "clustertool charts bump <version> <kind>",
    Args:    cobra.ExactArgs(2),
    Run: func(cmd *cobra.Command, args []string) {
        if err := version.Bump(args[0], args[1]); err != nil {
            log.Fatal().Err(err).Msg("failed to bump version")
        }
    },
}

func init() {
    charts.AddCommand(bumper)
}
