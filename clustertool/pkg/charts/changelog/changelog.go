package changelog

import (
    "fmt"
    "os"
    "sync"
    "time"

    "github.com/Masterminds/semver/v3"
    "github.com/go-git/go-git/v5"
    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

type ChangelogOptions struct {
    RepoPath                  string // Path to the repository (eg "./charts")
    TemplatePath              string // Path to the template file (eg "./changelog.tmpl")
    ChangelogFileName         string // Name of the changelog file eg "CHANGELOG.md"
    JSONOutputPath            string // Path to the JSON output file
    PrettyJSON                bool   // If true, the JSON output will be pretty-printed
    ChartsDir                 string // Dir where the charts are located (eg "./charts/")
    StatusUpdateInterval      int    // Interval in seconds between status updates
    SkipCommitsWithBadMessage bool   // If true, commits with bad messages will be skipped
}

func checkPath(path string, createIfNotExist bool) error {
    _, err := os.Stat(path)
    if err != nil {
        if os.IsNotExist(err) {
            if createIfNotExist {
                _, err := os.Create(path)
                if err != nil {
                    return fmt.Errorf("cannot create path %s: %w", path, err)
                }
                return nil
            }
            return nil
        }
        return fmt.Errorf("path %s cannot be used: %w", path, err)
    }
    return nil
}

func (o *ChangelogOptions) validate() error {
    if o.RepoPath == "" {
        return fmt.Errorf("repo path is empty")
    }
    if o.TemplatePath == "" {
        return fmt.Errorf("template path is empty")
    }
    if o.ChangelogFileName == "" {
        return fmt.Errorf("changelog file name is empty")
    }
    if o.ChartsDir == "" {
        return fmt.Errorf("charts dir is empty")
    }
    if o.JSONOutputPath == "" {
        return fmt.Errorf("json output path is empty")
    }
    if o.StatusUpdateInterval <= 0 {
        return fmt.Errorf("status update interval is zero")
    }

    paths := map[string]bool{
        o.TemplatePath:   false,
        o.RepoPath:       false,
        o.ChartsDir:      false,
        o.JSONOutputPath: false,
    }

    for path, create := range paths {
        if err := checkPath(path, create); err != nil {
            return err
        }
    }

    return nil
}

var changedData ChangedData = ChangedData{mu: &sync.RWMutex{}, Charts: make(map[string]*Chart)}
var stagingData ChangedData = ChangedData{mu: &sync.RWMutex{}, Charts: make(map[string]*Chart)}
var activeCharts ActiveCharts = ActiveCharts{items: make(map[string]ActiveChart), mu: &sync.RWMutex{}}
var currentStatus status = status{processedCount: 0, totalCount: 0, skippedCount: 0, avgTime: 0, totalProcessingTime: 0, mu: &sync.RWMutex{}}
var skipCommitsWithBadMessage bool
var dateFormat = "2006-01-02"

func (o *ChangelogOptions) Generate() error {
    start := time.Now()
    skipCommitsWithBadMessage = o.SkipCommitsWithBadMessage
    log.Info().Msgf("Starting changelog generation at %s", start)
    if err := o.validate(); err != nil {
        return err
    }
    // Get active train and charts
    if err := helper.WalkCharts2([]string{o.RepoPath}, activeCharts.getActiveChartsWalker, helper.AsyncMode); err != nil {
        return err
    }
    log.Info().Msgf("Found [%d] active charts in [%s]", len(activeCharts.items), time.Since(start))

    // Load existing json file
    if err := changedData.LoadFromFile(o.JSONOutputPath); err != nil {
        return fmt.Errorf("failed to load existing json file, maybe it is not matching the current structure: %w", err)
    }
    if changedData.LastCommit == "" {
        log.Info().Msgf("No last commit found in [%s], starting from the beginning", o.JSONOutputPath)
    } else {
        log.Info().Msgf("Last commit found in [%s], will start from [%s]", o.JSONOutputPath, changedData.LastCommit)
    }

    // Open repo
    repo, err := git.PlainOpen(o.RepoPath)
    if err != nil {
        return err
    }

    // Get list of commits. Order by committer time and only keep commits that are in the charts dir
    // the iterator will yield the newer commits first, so we need to reverse the order
    cIter, err := repo.Log(&git.LogOptions{Order: git.LogOrderCommitterTime})
    if err != nil {
        return err
    }
    commits, err := o.reverseCommits(cIter, changedData.LastCommit)
    if err != nil {
        return err
    }
    if len(commits) == 0 {
        log.Info().Msgf("No commits to process in %s", o.RepoPath)
        return nil
    }
    log.Info().Msgf("Found [%d] commits to process in %s", len(commits), o.RepoPath)

    stop := make(chan struct{}) // Stop channel
    defer close(stop)
    go o.statusPrinter(stop)

    // TODO: Once go-git is thread safe, we can parallelize this
    // https://github.com/go-git/go-git/issues/773
    for _, c := range commits {
        changedData.mu.Lock()
        changedData.LastCommit = c.Hash.String()
        changedData.mu.Unlock()
        commitStart := time.Now()

        if err := processCommit(c); err != nil {
            log.Error().Err(err).Msgf("Error processing commit: %s", c.Hash.String())
            return err
        }

        currentStatus.mu.Lock()
        currentStatus.processedCount++
        currentStatus.totalProcessingTime += time.Since(commitStart)
        currentStatus.avgTime = currentStatus.totalProcessingTime / time.Duration(currentStatus.processedCount+currentStatus.skippedCount)
        currentStatus.mu.Unlock()
    }

    stop <- struct{}{}

    if err := mergeStagingToCurrent(); err != nil {
        return err
    }
    if err := changedData.WriteToFile(o.JSONOutputPath); err != nil {
        return fmt.Errorf("error writing json new file: %s", err)
    }
    log.Info().Msgf("Finished in %s", time.Since(start))
    o.printStatus(start, false)
    return nil
}

// We have to go over the stagingData, for each chart,
// we sort the versions from the changelogData
// and we add the commits from stagingData to the nearest next version in changelogData
func mergeStagingToCurrent() error {
    start := time.Now()
    log.Info().Msgf("Merging staging to current", )
    changedData.mu.Lock()
    defer changedData.mu.Unlock()

    stagingData.mu.Lock()
    defer stagingData.mu.Unlock()
    for chart, stagingChartItem := range stagingData.Charts {
        // If the staging chart doesn't exist in the changelogData, we add it and go to the next chart
        chartItem, ok := changedData.Charts[chart]
        if !ok {
            changedData.Charts[chart] = stagingChartItem
            continue
        }

        // If the chart exists in the changelogData but does not have any versions
        // we add the versions from stagingData and go to the next chart (probably a new chart)
        if chartItem.Versions == nil || len(chartItem.Versions) == 0 {
            chartItem.Versions = stagingChartItem.Versions
            continue
        }

        // Get all the versions from the changedData chart
        chartVersions, err := chartItem.SortVersions(false)
        if err != nil {
            return err
        }

        // Go over the versions in stagingData chart,
        // for each version, we find the immediately next version in changedData chart
        for versionKey := range stagingData.Charts[chart].Versions {
            stagingVer, err := semver.NewVersion(versionKey)
            if err != nil { // This should never happen
                return err
            }

            foundGreater := false
            // Go over the versions in the changedData chart versions
            for _, chartVer := range chartVersions {
                // If the changedData version is greater than the staging version,
                // we add the commits to this version and break
                if !chartVer.GreaterThan(stagingVer) {
                    continue
                }
                foundGreater = true
                chartVerItem, ok := chartItem.Versions[versionKey]
                if !ok {
                    chartItem.AddVersion(versionKey, stagingChartItem.Versions[versionKey].Train)
                    chartVerItem = chartItem.Versions[versionKey]
                }

                // Add the commits from stagingData to the given version in the changedData chart
                for commitKey, commit := range stagingChartItem.Versions[versionKey].Commits {
                    if chartVerItem.Commits == nil {
                        log.Warn().Msgf("Commits were nil for version [%s] in chart [%s]", versionKey, chart)
                        chartVerItem.Commits = make(map[string]*Commit)
                    }

                    if _, ok := chartVerItem.Commits[commitKey]; ok {
                        // This should never happen, but we log it just in case
                        log.Warn().Msgf("Commit [%s] already exists in version [%s]", commitKey, versionKey)
                        continue
                    }
                    chartVerItem.Commits[commitKey] = commit
                }
                break
            }
            if !foundGreater {
                // Add the version to the changedData chart
                for commitKey, commit := range stagingChartItem.Versions[versionKey].Commits {
                    if _, ok := chartItem.Versions[versionKey].Commits[commitKey]; ok {
                        // This should never happen, but we log it just in case
                        log.Warn().Msgf("Commit [%s] already exists in version [%s]", commitKey, versionKey)
                        continue
                    }
                    chartItem.Versions[versionKey].Commits[commitKey] = commit
                }
            }
        }

    }

    log.Info().Msgf("Finished merging in %s", time.Since(start))
    return nil
}
