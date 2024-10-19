package readme

import (
    "fmt"
    "os"
    "path/filepath"
    "strings"

    "github.com/rs/zerolog/log"
)

func GenerateReadme(templatePath string, chartPath string, chartName string, train string) error {
    // Define file paths
    template := filepath.Join(templatePath, "templates/README.md.tpl")
    target := filepath.Join(filepath.Dir(chartPath), "README.md")

    // Read template file
    templateContent, err := os.ReadFile(template)
    if err != nil {
        return fmt.Errorf("failed to read template file: %v", err)
    }

    // Replace placeholders in the template
    readmeContent := strings.ReplaceAll(string(templateContent), "TRAINPLACEHOLDER", train)
    readmeContent = strings.ReplaceAll(readmeContent, "CHARTPLACEHOLDER", chartName)

    // Write the modified content to the README.md file in the chart directory
    err = os.WriteFile(target, []byte(readmeContent), 0644)
    if err != nil {
        return fmt.Errorf("failed to write README.md file: %v", err)
    }

    log.Info().Msgf("Generated README.md for [%s] in [%s] train", chartName, train)
    return nil
}
