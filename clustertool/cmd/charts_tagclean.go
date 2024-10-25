package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/charts/image"
)

var chartsTagCleanLongHelp = strings.TrimSpace(`

`)

var tagCleaner = &cobra.Command{
    Use:     "tagcleaner",
    Short:   "Creates a clean version tag from a container digest",
    Long:    chartsTagCleanLongHelp,
    Example: "clustertool charts tagclean <tag>",
    Args:    cobra.ExactArgs(1),
    Run: func(cmd *cobra.Command, args []string) {
        err := image.Clean(args[0])
        if err != nil {
            log.Fatal().Err(err).Msg("failed to clean tag")
        }
    },
}

func init() {
    charts.AddCommand(tagCleaner)
}
