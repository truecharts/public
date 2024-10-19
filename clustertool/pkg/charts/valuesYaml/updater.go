package valuesYaml

import (
    "fmt"
    "os"
    "path/filepath"

    "github.com/rs/zerolog/log"
)

// UpdatevaluesFile updates the specified values.yaml file with an optional bump parameter.
func UpdatevaluesFile(valuesPathOrFolder, bump string) error {
    var chartFolder string
    var valuesPath string

    fileInfo, err := os.Stat(valuesPathOrFolder)
    if err != nil {
        return err
    }

    if fileInfo.IsDir() {
        chartFolder = valuesPathOrFolder
    } else {
        chartFolder = filepath.Dir(valuesPathOrFolder)

    }
    valuesPath = filepath.Join(chartFolder, "values.yaml")

    log.Printf("Processing: %s\n", valuesPath)
    values := NewValuesFile()
    if err := values.LoadFromFile(valuesPath); err != nil {
        log.Info().Msgf("Error loading values: %v\n", err)
        return err
    }

    // Save the modified metadata back to the file
    if err := values.SaveToFile(valuesPath); err != nil {
        return fmt.Errorf("error saving values.yaml: %s", err)
    }

    log.Printf("values file updated and saved to %s\n", valuesPath)

    return nil
}
