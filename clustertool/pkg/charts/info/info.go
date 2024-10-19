package info

import (
    "runtime/debug"
    "time"

    "github.com/rs/zerolog/log"
)

type Data struct {
    GoVersion string
    GoArch    string
    GoOS      string
    GoC       bool
    GitCommit string
    GitDate   time.Time
    GitDirty  bool
}

func NewInfo() *Data {
    info, _ := debug.ReadBuildInfo()
    data := &Data{
        GoVersion: info.GoVersion,
    }

    // Available info: https://github.com/golang/go/blob/master/src/runtime/debug/mod.go#L73
    for _, kv := range info.Settings {
        switch kv.Key {
        case "GOARCH":
            data.GoArch = kv.Value
        case "GOOS":
            data.GoOS = kv.Value
        case "CGO_ENABLED":
            data.GoC = kv.Value == "1"
        case "vcs.revision":
            data.GitCommit = kv.Value
        case "vcs.time":
            data.GitDate, _ = time.Parse(time.RFC3339, kv.Value)
        case "vcs.modified":
            data.GitDirty = kv.Value == "true"
        }
    }

    return data
}

func (d *Data) Print() {
    log.Info().Msgf(`
Charttool is a tool for managing TrueCharts charts.

Go
    Version: %s
    OS: %s
    Arch: %s
    CGO: %t
Git
    Commit: %s
    Date: %s
    Dirty: %t
`, d.GoVersion, d.GoOS, d.GoArch, d.GoC, d.GitCommit, d.GitDate, d.GitDirty)
}
