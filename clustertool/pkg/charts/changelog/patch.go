package changelog

import (
    "errors"
    "fmt"
    "strings"

    "github.com/Masterminds/semver/v3"
    "github.com/go-git/go-git/v5/plumbing/format/diff"
    "github.com/go-git/go-git/v5/plumbing/object"
    "github.com/rs/zerolog/log"
)

var errSkipPatch = errors.New("skip patch")

func getChangedFilePair(p diff.FilePatch) (string, oldNewPaths, error) {
    old, new := p.Files()
    if new == nil { // No new file, nothing to do
        log.Debug().Msgf("Skipping file patch. Reason: New file is empty")
        return "", oldNewPaths{}, errSkipPatch
    }

    // Get chart name and check if its an active chart
    // if the new.Path() is a path outside of the charts folder,
    // it will not be an active chart anyway and so we skip the diff
    chartName := getChartName(new.Path())
    if chartName == invalidName || !activeCharts.isActiveChart(chartName) {
        log.Debug().Msgf("Skipping file patch. Reason: [%s] is not an active chart", new.Path())
        return "", oldNewPaths{}, errSkipPatch
    }
    if _, err := getChartPath(new.Path()); err != nil {
        log.Debug().Msgf("Skipping file patch. Reason: [%s] is not a valid chart path", new.Path())
        return "", oldNewPaths{}, errSkipPatch
    }
    if old != nil { // If an old file exists in the patch
        if _, err := getChartPath(old.Path()); err != nil {
            log.Debug().Msgf("Skipping file patch. Reason: [%s] is not a valid chart path", old.Path())
            return "", oldNewPaths{}, errSkipPatch
        }
    }

    return chartName, oldNewPaths{new: new, old: old}, nil
}

func getOldAndNewVersion(c *object.Commit, par *object.Commit, paths oldNewPaths) (string, string, error) {
    newChartPath, err := getChartPath(paths.new.Path())
    if err != nil {
        return "", "", fmt.Errorf("failed to get chart path from file path [%s]: %w", paths.new.Path(), err)
    }
    newChartVer, err := getChartVersion(c, newChartPath)
    if err != nil {
        return "", "", fmt.Errorf("failed to get chart data from path [%s]: %w", newChartPath, err)
    }

    oldChartVer := ""
    if paths.old != nil { // If an old file exists in the patch
        oldChartPath, err := getChartPath(paths.old.Path())
        if err != nil {
            return "", "", fmt.Errorf("failed to get chart path from file path [%s]: %w", paths.old.Path(), err)
        }
        // Note here we pass the parent commit, not the current commit
        oldChartVer, err = getChartVersion(par, oldChartPath)
        if err != nil {
            return "", "", fmt.Errorf("failed to get chart data from path [%s]: %w", oldChartPath, err)
        }
    }

    return oldChartVer, newChartVer, nil
}

func getChartsWithMultipleChangedFiles(p *object.Patch) (chartsWithChangedFiles, error) {
    chartsWithMultipleFiles := make(chartsWithChangedFiles)
    for _, p := range p.FilePatches() {
        // Get chart name and the "new" file path
        chartName, paths, err := getChangedFilePair(p)
        if err != nil {
            if errors.Is(err, errSkipPatch) {
                continue
            }
            return chartsWithChangedFiles{}, fmt.Errorf("failed to get changed files: %w", err)
        }
        // if there is no new file, skip the filePatch
        if paths.new.Path() == "" {
            continue
        }

        // Add the file to the charts changed files
        chartsWithMultipleFiles[chartName] = append(chartsWithMultipleFiles[chartName], paths)
    }

    return chartsWithMultipleFiles, nil
}

func getChartsWithSingleChangedFile(c chartsWithChangedFiles) chartsWithChangedFile {
    chartsWithSingleFile := make(chartsWithChangedFile)
    for chartName, filePaths := range c {
        for _, paths := range filePaths {
            _, ok := chartsWithSingleFile[chartName]
            // If the chart hasn't been seen before,
            // or the filePath is a Chart.yaml file
            // we add the pair to the map
            if !ok || strings.HasSuffix(paths.new.Path(), "Chart.yaml") {
                chartsWithSingleFile[chartName] = paths
                continue
            }
        }
    }
    return chartsWithSingleFile
}

func processChartsWithSingleChangedFile(c *object.Commit, par *object.Commit, chartsWithSingleFile chartsWithChangedFile) error {
    // For each chart, get the old and new versions
    for chartName, paths := range chartsWithSingleFile {
        oldVer, newVer, err := getOldAndNewVersion(c, par, paths)
        if err != nil {
            return fmt.Errorf("failed to get old and new versions: %w", err)
        }
        // If the old version is empty, (chart addition)
        // we add the new version to the changedData
        if oldVer == "" {
            changedData.mu.Lock()
            changedData.AddOrUpdateChart(chartName, newVer, getChartTrain(paths.new.Path()), c)
            changedData.mu.Unlock()
            continue
        }

        oldSemVer, err := semver.NewVersion(oldVer)
        if err != nil {
            return fmt.Errorf("failed to parse old version ([%s]) for file [%s] in commit [%s]: %w", oldVer, paths.new.Path(), c.Hash.String(), err)
        }
        newSemVer, err := semver.NewVersion(newVer)
        if err != nil {
            return fmt.Errorf("failed to parse new version ([%s]) for file [%s] in commit [%s]: %w", newVer, paths.new.Path(), c.Hash.String(), err)
        }

        // if new version is greater than the old version, we add the new version to the changedData
        if newSemVer.GreaterThan(oldSemVer) {
            changedData.mu.Lock()
            changedData.AddOrUpdateChart(chartName, newVer, getChartTrain(paths.new.Path()), c)
            changedData.mu.Unlock()
            continue
        }

        // Otherwise, we add the new version to the stagingData
        // It is probably less or equal to the old version,
        // in either case the chart changes is unreleased.
        // so it should go to the "next" version, we do that at the end
        // although if its less, it will be hard to actually get which is the "next" version
        // but we can't really do anything about it, so just put it on the immediate next version
        stagingData.mu.Lock()
        stagingData.AddOrUpdateChart(chartName, newVer, getChartTrain(paths.new.Path()), c)
        stagingData.mu.Unlock()
    }
    return nil
}
