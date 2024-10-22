package scale

import (
    "bytes"
    "encoding/json"
    "fmt"
    "io/ioutil"
    "os"
    "os/exec"
    "path/filepath"

    "github.com/rs/zerolog/log"
)

func ExportApps() {
    // Execute the command and capture its output
    cmd := exec.Command("midclt", "call", "chart.release.query")
    var out bytes.Buffer
    cmd.Stdout = &out
    if err := cmd.Run(); err != nil {
        log.Error().Err(err).Msgf("Error executing command: %v\n", err)

        os.Exit(1)
    }

    // Parse the JSON output
    var releases []map[string]interface{}
    if err := json.Unmarshal(out.Bytes(), &releases); err != nil {
        log.Error().Err(err).Msgf("Error parsing JSON: %v\n", err)

        os.Exit(1)
    }

    // Ensure the directory exists
    outputDir := "./truenas_exports"
    if err := os.MkdirAll(outputDir, 0755); err != nil {
        log.Error().Err(err).Msgf("Error creating directory: %v\n", err)

        os.Exit(1)
    }

    // Save each release to a separate file
    for _, release := range releases {
        // Extract the release name
        name, ok := release["name"].(string)
        if !ok {
            fmt.Fprintf(os.Stderr, "Error: release does not have a name field or it is not a string\n")
            continue
        }

        // Marshal the release data to JSON
        data, err := json.MarshalIndent(release, "", "  ")
        if err != nil {
            log.Error().Err(err).Msgf("Error marshaling JSON: %v\n", err)

            continue
        }

        // Create the filename using the release name
        filename := filepath.Join(outputDir, fmt.Sprintf("%s.json", name))
        if err := ioutil.WriteFile(filename, data, 0644); err != nil {
            log.Error().Err(err).Msgf("Error writing file: %v\n", err)

        }
    }
}
