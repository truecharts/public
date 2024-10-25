package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/charts/changelog"
)

var chartsGenChangelogLongHelp = strings.TrimSpace(`

`)

var genChangelogCmd = &cobra.Command{
    Use:     "genchangelog",
    Short:   "Generate changelog for charts",
    Long:    chartsGenChangelogLongHelp,
    Example: "clustertool charts genchangelog <repo path> <template path> <charts dir>",
    Run: func(cmd *cobra.Command, args []string) {
        if len(args) < 3 {
            log.Fatal().Msg("Missing required arguments. Please provide the repo path, template path and charts directory.")
        }
        opts := &changelog.ChangelogOptions{
            RepoPath:                  args[0],
            TemplatePath:              args[1],
            ChartsDir:                 args[2],
            ChangelogFileName:         "CHANGELOG.md",
            JSONOutputPath:            "./changelog.json",
            PrettyJSON:                true,
            StatusUpdateInterval:      5,
            SkipCommitsWithBadMessage: false,
        }
        if err := opts.Generate(); err != nil {
            log.Fatal().Err(err)
        }
        if err := opts.Render(); err != nil {
            log.Fatal().Err(err)
        }
    },
}

func init() {
    charts.AddCommand(genChangelogCmd)
}
