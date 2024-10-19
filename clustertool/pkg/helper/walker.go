package helper

import (
    "io/fs"
    "path/filepath"
    "sync"

    "github.com/rs/zerolog/log"
)

func WalkCharts2(paths []string, fn fs.WalkDirFunc, mode WalkMode) error {
    if len(paths) == 0 {
        // If paths is empty, default to processing all charts in the charts directory
        paths = []string{"./charts"}
    }
    var wg sync.WaitGroup

    for _, dir := range paths {
        wg.Add(1)
        go func(dir string) {
            defer wg.Done()
            if err := filepath.WalkDir(dir, fn); err != nil {
                log.Info().Msgf("Error walking directory %s: %s\n", dir, err)
            }
        }(dir)

        if mode == SyncMode {
            // Wait for THIS goroutine to finish
            wg.Wait()
        }
    }

    if mode == AsyncMode {
        // Wait for all goroutines to finish
        wg.Wait()
    }

    return nil
}
