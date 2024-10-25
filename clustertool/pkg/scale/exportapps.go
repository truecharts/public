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
    log.Info().Msg("Starting the ExportApps process")

    // Execute the command and capture its output
    cmd := exec.Command("midclt", "call", "chart.release.query")
    var out bytes.Buffer
    cmd.Stdout = &out
    log.Trace().Strs("command", cmd.Args).Msg("Executing command to fetch chart releases")

    if err := cmd.Run(); err != nil {
        log.Error().Err(err).Msgf("Error executing command: %v\n", err)
        os.Exit(1)
    }

    log.Info().Msg("Successfully executed command to fetch chart releases")

    // Parse the JSON output
    var releases []map[string]interface{}
    log.Debug().Msg("Parsing JSON output from command")
    if err := json.Unmarshal(out.Bytes(), &releases); err != nil {
        log.Error().Err(err).Msgf("Error parsing JSON: %v\n", err)
        os.Exit(1)
    }

    log.Info().Int("release_count", len(releases)).Msg("Parsed releases from JSON output")

    // Ensure the directory exists
    outputDir := "./truenas_exports"
    log.Trace().Str("directory", outputDir).Msg("Checking if output directory exists")
    if err := os.MkdirAll(outputDir, 0755); err != nil {
        log.Error().Err(err).Msgf("Error creating directory: %v\n", err)
        os.Exit(1)
    }

    log.Info().Msg("Output directory ensured successfully")

    // Save each release to a separate file
    for _, release := range releases {
        // Extract the release name
        name, ok := release["name"].(string)
        if !ok {
            log.Warn().Msg("Release does not have a name field or it is not a string")
            continue
        }

        // Marshal the release data to JSON
        data, err := json.MarshalIndent(release, "", "  ")
        if err != nil {
            log.Error().Err(err).Msgf("Error marshaling JSON for release %s: %v\n", name, err)
            continue
        }

        // Create the filename using the release name
        filename := filepath.Join(outputDir, fmt.Sprintf("%s.json", name))
        log.Debug().Str("filename", filename).Msg("Writing release data to file")

        if err := ioutil.WriteFile(filename, data, 0644); err != nil {
            log.Error().Err(err).Msgf("Error writing file %s: %v\n", filename, err)
            continue
        }

        log.Info().Str("release_name", name).Msg("Successfully wrote release data to file")
    }

    log.Info().Msg("ExportApps process completed")
}
