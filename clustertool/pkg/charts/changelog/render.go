package changelog

import (
    "bytes"
    "html/template"
    "os"
    "path/filepath"
    "sync"
    "time"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

func (o *ChangelogOptions) Render() error {
    start := time.Now()
    log.Info().Msgf("Starting changelog render at %s", start)

    changelogData := ChangedData{mu: &sync.RWMutex{}, Charts: make(map[string]*Chart)}
    activeCharts := ActiveCharts{items: make(map[string]ActiveChart), mu: &sync.RWMutex{}}
    if err := changelogData.LoadFromFile(o.JSONOutputPath); err != nil {
        log.Fatal().Err(err).Msgf("failed to load %s", o.JSONOutputPath)
    }
    if err := helper.WalkCharts2([]string{o.RepoPath}, activeCharts.getActiveChartsWalker, helper.AsyncMode); err != nil {
        log.Fatal().Err(err).Msg("failed to walk charts")
    }

    for _, chart := range activeCharts.items {
        if changelogData.Charts[chart.Name] == nil {
            log.Error().Msgf("chart [%s] not found in %s", chart.Name, o.JSONOutputPath)
            continue

        }
        if changelogData.Charts[chart.Name].Versions == nil {
            log.Error().Msgf("chart [%s] has no versions in %s", chart.Name, o.JSONOutputPath)
            continue
        }
        // load template
        tmpl, err := template.ParseFiles(o.TemplatePath)
        if err != nil {
            log.Fatal().Err(err).Msgf("failed to parse %s", o.TemplatePath)
        }

        if _, err := changelogData.Charts[chart.Name].SortVersions(true); err != nil {
            log.Fatal().Err(err).Msgf("failed to sort versions for %s", chart.Name)
        }
        for _, version := range changelogData.Charts[chart.Name].Versions {
            version.SortedCommits, err = version.SortCommits(true)
            if err != nil {
                log.Fatal().Err(err).Msgf("failed to sort commits for version [%s] in chart [%s]", version.Version, chart.Name)
            }
        }

        changelogData.Charts[chart.Name].Name = chart.Name
        changelogData.Charts[chart.Name].Train = chart.Train
        // render template
        var buf bytes.Buffer
        err = tmpl.Execute(&buf, changelogData.Charts[chart.Name])
        if err != nil {
            log.Fatal().Err(err).Msgf("failed to render %s", o.TemplatePath)
        }

        output := filepath.Join(o.ChartsDir, chart.Train, chart.Name)
        if err := os.MkdirAll(output, os.ModePerm); err != nil {
            log.Fatal().Err(err).Msgf("failed to create %s directory", output)
        }
        // write rendered template to file
        if err := os.WriteFile(filepath.Join(output, o.ChangelogFileName), buf.Bytes(), 0644); err != nil {
            log.Fatal().Err(err).Msgf("failed to write %s", o.ChangelogFileName)
        }
    }

    log.Info().Msgf("Finished in %s", time.Since(start))
    return nil
}
