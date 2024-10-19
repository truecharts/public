package helper

import (
    "fmt"
    "io/fs"
    "os"
    "path/filepath"
    "slices"
    "sync"

    "github.com/rs/zerolog/log"
)

var ExcludedDirs = []string{
    "templates", ".github", "docs",
    ".vscode", "tools", ".devcontainer",
    "testdata",
}

// WalkMode specifies the mode for walking charts
type WalkMode int

const (
    // SyncMode processes charts sequentially
    SyncMode WalkMode = iota
    // AsyncMode processes charts concurrently
    AsyncMode
)

type ActionFunc func(string, string) error

func getWalkDirFunc(action ActionFunc, bump string, mode WalkMode, wg *sync.WaitGroup) fs.WalkDirFunc {
    return func(path string, info os.DirEntry, err error) error {
        if err != nil {
            return err
        }

        if info.IsDir() && slices.Contains(ExcludedDirs, info.Name()) {
            return filepath.SkipDir
        }

        // Check if the current file is Chart.yaml
        if info.Name() == "Chart.yaml" {
            switch mode {
            case SyncMode:
                // Process charts sequentially
                if err := action(path, bump); err != nil {
                    log.Fatal().Err(err).Msgf("Error executing action on Chart.yaml at [%s]", path)
                }
            case AsyncMode:
                // Process charts concurrently
                wg.Add(1)
                go func(path string) {
                    defer wg.Done()
                    if err := action(path, bump); err != nil {
                        log.Fatal().Err(err).Msgf("Error executing action on Chart.yaml at [%s]", path)
                    }
                }(path)
            default:
                return fmt.Errorf("invalid mode: %d", mode)
            }

            // Stop processing the current directory after finding Chart.yaml
            return filepath.SkipDir
        }

        return nil
    }
}

// TODO: Replace with WalkCharts2, first we have to refactor the "action" function
// Should be a valid fs.WalkDirFunc, if we need to add state to that function,
// we can use a closure to pass the state.

// UpdateChartFiles traverses Chart.yaml files based on the provided paths and executes the specified function.
// If paths is empty, process all charts.
// The mode parameter toggles between synchronous and asynchronous modes.
func WalkCharts(paths []string, action func(string, string) error, bump string, mode WalkMode) error {
    var wg sync.WaitGroup

    if len(paths) == 0 {
        // If paths is empty, default to processing all charts in the charts directory
        paths = []string{"./charts"}
    }

    for _, rootDir := range paths {

        err := filepath.WalkDir(rootDir, getWalkDirFunc(action, bump, mode, &wg))

        if err != nil {
            return fmt.Errorf("error walking directory %s: %s", rootDir, err)
        }
    }

    // Wait for all goroutines to finish in asynchronous mode
    if mode == AsyncMode {
        wg.Wait()
    }

    return nil
}

func UniqueNonEmptyElementsOf(s []string) []string {
    unique := make(map[string]bool, len(s))
    us := make([]string, len(unique))
    for _, elem := range s {
        if len(elem) != 0 {
            if !unique[elem] {
                us = append(us, elem)
                unique[elem] = true
            }
        }
    }

    return us

}
