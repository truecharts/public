package helper

import (
    "bytes"
    "io"
    "os"
    "os/exec"
    "strings"

    "github.com/rs/zerolog/log"
)

type filteredWriter struct {
    writer  io.Writer
    filters []string
}

func (fw *filteredWriter) Write(p []byte) (n int, err error) {
    lines := strings.Split(string(p), "\n")
    var filteredLines []string
    for _, line := range lines {
        shouldFilter := false
        for _, filter := range fw.filters {
            if strings.Contains(line, filter) {
                shouldFilter = true
                break
            }
        }
        if !shouldFilter {
            filteredLines = append(filteredLines, line)
        }
    }
    return fw.writer.Write([]byte(strings.Join(filteredLines, "\n")))
}

func RunCommand(commandSlice []string, silent bool) (string, error) {
    filters := []string{"certificate signed by unknown authority", "bootstrap is not available yet"}
    log.Trace().Msg("Command slice structure:")
    for i, s := range commandSlice {
        log.Trace().Msgf("Index: %d, Value: %s\n", i, s)
    }
    cmd := exec.Command(commandSlice[0], commandSlice[1:]...)

    var stdoutBuf, stderrBuf bytes.Buffer
    if silent {
        cmd.Stdout = &stdoutBuf
        cmd.Stderr = &stderrBuf
    } else {
        cmd.Stdout = io.MultiWriter(&stdoutBuf, &filteredWriter{writer: os.Stdout, filters: filters})
        cmd.Stderr = io.MultiWriter(&stderrBuf, &filteredWriter{writer: os.Stderr, filters: filters})
    }

    err := cmd.Run()
    if err != nil {
        return stdoutBuf.String() + stderrBuf.String(), err
    }

    return stdoutBuf.String() + stderrBuf.String(), nil
}
