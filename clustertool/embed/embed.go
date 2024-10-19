package embed

import (
    "embed"
    "io/fs"
    "os"
    "path/filepath"
    "runtime"

    "github.com/rs/zerolog/log"

    "github.com/leaanthony/debme"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

//go:embed generic/*
var GenericFiles embed.FS
var TalosExec string

func AllToCache() {
    err := os.RemoveAll(helper.CacheDir)
    if err != nil {
        log.Fatal().Err(err)
    }
    GOOSARCH := runtime.GOOS + "_" + runtime.GOARCH
    filesToCache(StaticFiles, GOOSARCH)
    filesToCache(GenericFiles, "generic")
}

func filesToCache(embededfs embed.FS, sub string) {

    // Ensure the base cache directory exists
    if err := os.MkdirAll(helper.CacheDir, os.ModePerm); err != nil {
        log.Info().Msgf("Error creating base cache directory: %v", err)
        return
    }

    root, _ := debme.FS(embededfs, sub)
    fs.WalkDir(root, ".", func(path string, d fs.DirEntry, err error) error {
        if err != nil {
            return err
        }
        if d.Name() != sub {
            if d.IsDir() {
                // If it's a directory, create the corresponding directory in the cache
                writePath := filepath.Join(helper.CacheDir, path)
                if err := os.MkdirAll(writePath, os.ModePerm); err != nil {
                    log.Info().Msgf("Error creating directory in cache: %v", err)
                    return err
                }
            } else {

                // If it's a file, read and write it to the cache
                data, err := root.ReadFile(path)
                if err != nil {
                    log.Info().Msgf("Error reading file: %v", err)
                    return err
                }
                writePath := filepath.Join(helper.CacheDir, path)
                if err := os.WriteFile(writePath, data, 0755); err != nil {
                    log.Info().Msgf("Error writing file to cache: %v", err)
                    return err
                }
            }
        }
        return nil
    })
}

func GetTalosExec() string {
    execName := ""
    if runtime.GOOS == "windows" {
        if runtime.GOARCH == "amd64" {
            execName = "talosctl-windows-amd64.exe"
        } else {
            execName = "talosctl-windows-arm64.exe"
        }

    }
    if runtime.GOOS == "linux" {
        if runtime.GOARCH == "amd64" {
            execName = "talosctl-linux-amd64"
        } else {
            execName = "talosctl-linux-arm64"
        }

    }
    if runtime.GOOS == "darwin" {
        if runtime.GOARCH == "amd64" {
            execName = "talosctl-darwin-amd64"
        } else {
            execName = "talosctl-darwin-arm64"
        }

    }
    if runtime.GOOS == "freebsd" {
        if runtime.GOARCH == "amd64" {
            execName = "talosctl-freebsd-amd64"
        } else {
            execName = "talosctl-freebsd-arm64"
        }

    }

    return filepath.Join(helper.CacheDir, execName)

}
