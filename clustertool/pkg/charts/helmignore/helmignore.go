package helmignore

import (
    "fmt"
    "os"
    "path/filepath"

    "github.com/rs/zerolog/log"
)

func GenerateHelmIgnore(templatePath string, chartPath string) error {
    // Define file paths
    template := filepath.Join(templatePath, "templates/helmignore.tpl")
    target := filepath.Join(filepath.Dir(chartPath), ".helmignore")

    // Read template file
    templateContent, err := os.ReadFile(template)
    if err != nil {
        return fmt.Errorf("failed to read template file: %v", err)
    }

    // Write the modified content to the .helmignore file in the chart directory
    err = os.WriteFile(target, []byte(templateContent), 0644)
    if err != nil {
        return fmt.Errorf("failed to write .helmignore file: %v", err)
    }

    log.Info().Msgf("Generated .helmignore for [%s]", chartPath)
    return nil
}
