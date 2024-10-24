package scale

import (
    "encoding/json"
    "fmt"
    "io/ioutil"
    "os"
    "path"
    "path/filepath"
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/fluxhandler"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "gopkg.in/yaml.v3"
)

type RadarrConfig struct {
    Name          string                 `json:"name"`
    Namespace     string                 `json:"namespace"`
    Info          map[string]interface{} `json:"info"`
    Config        map[string]interface{} `json:"config"`
    ChartMetadata map[string]interface{} `json:"chart_metadata"`
}

// removeKeysStartingWithIX recursively removes keys starting with "ix" or "IX" from a map
func removeKeysStartingWithIX(data map[string]interface{}) {
    for key := range data {
        lowerKey := strings.ToLower(key)
        if strings.HasPrefix(lowerKey, "ix") {
            delete(data, key)
        } else {
            // If the value is a nested map, recursively remove keys
            if nestedMap, ok := data[key].(map[string]interface{}); ok {
                removeKeysStartingWithIX(nestedMap)
            }
        }
    }
}

// mergeLists merges "somethingList" with "something" based on the "name" key
func mergeLists(config map[string]interface{}) {
    for key, value := range config {
        if strings.HasSuffix(key, "List") {
            baseKey := strings.TrimSuffix(key, "List")
            if baseMap, ok := config[baseKey].(map[string]interface{}); ok {
                if list, ok := value.([]interface{}); ok {
                    for _, item := range list {
                        if itemMap, ok := item.(map[string]interface{}); ok {
                            if name, exists := itemMap["name"].(string); exists {
                                baseMap[name] = itemMap
                            }
                        }
                    }
                }
            } else {
                newMap := make(map[string]interface{})
                if list, ok := value.([]interface{}); ok {
                    for _, item := range list {
                        if itemMap, ok := item.(map[string]interface{}); ok {
                            if name, exists := itemMap["name"].(string); exists {
                                newMap[name] = itemMap
                            }
                        }
                    }
                    config[baseKey] = newMap
                }
            }
            delete(config, key)
        } else {
            // If the value is a nested map, recursively merge lists
            if nestedMap, ok := value.(map[string]interface{}); ok {
                mergeLists(nestedMap)
            }
        }
    }
}

// removeSpecificKeys removes specific keys from the root-level of config/values
func removeSpecificKeys(config map[string]interface{}) {
    specificKeys := []string{
        "donateNag",
        "docs",
        "image",
        "expertPodOpts",
        "advanced",
        "portal",
        "requests",
        "global",
    }

    for _, key := range specificKeys {
        deleteKeyRecursive(config, key)
    }
}

// deleteKeyRecursive recursively deletes a key from config and its nested maps
func deleteKeyRecursive(config interface{}, key string) {
    switch c := config.(type) {
    case map[string]interface{}:
        if _, ok := c[key]; ok {
            delete(c, key)
        } else {
            for _, v := range c {
                deleteKeyRecursive(v, key)
            }
        }
    case []interface{}:
        for _, v := range c {
            deleteKeyRecursive(v, key)
        }
    }
}

// removeEmptyLists recursively removes empty lists from the config
func removeEmptyLists(config map[string]interface{}) {
    for key, value := range config {
        if list, ok := value.([]interface{}); ok && len(list) == 0 {
            delete(config, key)
        } else if nestedMap, ok := value.(map[string]interface{}); ok {
            removeEmptyLists(nestedMap)
        }
    }
}

// removeEmptyDicts recursively removes empty dictionaries from the config
func removeEmptyDicts(config map[string]interface{}) {
    for key, value := range config {
        if subMap, ok := value.(map[string]interface{}); ok {
            if len(subMap) == 0 {
                delete(config, key)
            } else {
                removeEmptyDicts(subMap)
            }
        }
    }
}

// removeIXPrefix removes the "ix-" prefix from the namespace
func removeIXPrefix(namespace string) string {
    if strings.HasPrefix(namespace, "ix-") {
        return namespace[3:]
    }
    return namespace
}

// removePortalOpenDisabled removes portal.open.enabled: false if nothing else is defined under portal.open
func removePortalOpenDisabled(config map[string]interface{}) {
    removeKeyIfValueRecursive(config, "portal.open.enabled", false)
}

// removeAdvancedSettings removes instances of advanced: false or advanced: true
func removeAdvancedSettings(config map[string]interface{}) {
    removeKeyIfValueRecursive(config, "advanced", false)
    removeKeyIfValueRecursive(config, "advanced", true)
}

// removeKeyIfValueRecursive recursively deletes a key in config based on a dot-separated key path and value
func removeKeyIfValueRecursive(config interface{}, keyPath string, value interface{}) {
    switch c := config.(type) {
    case map[string]interface{}:
        keys := strings.Split(keyPath, ".")
        if len(keys) == 1 {
            if c[keys[0]] == value {
                delete(c, keys[0])
            }
        } else {
            if v, ok := c[keys[0]]; ok {
                removeKeyIfValueRecursive(v, strings.Join(keys[1:], "."), value)
            }
        }
    case []interface{}:
        for _, v := range c {
            removeKeyIfValueRecursive(v, keyPath, value)
        }
    }
}

// removeSpecificKeyValues removes specific key-value pairs from the config
func removeSpecificKeyValues(config map[string]interface{}) {
    specificKeyValues := map[string]interface{}{
        "amd.com/gpu":         float64(0), // Use float64(0) to match JSON unmarshal output
        "cpu":                 "4000m",
        "gpu.intel.com/i915":  float64(0), // Use float64(0) to match JSON unmarshal output
        "memory":              "8Gi",
        "nvidia.com/gpu":      float64(0),   // Use float64(0) to match JSON unmarshal output
        "PUID":                float64(568), // Use float64(568) to match JSON unmarshal output
        "UMASK":               "\"0022\"",
        "fsGroup":             float64(568), // Use float64(568) to match JSON unmarshal output
        "fsGroupChangePolicy": "Always",
        "readOnly":            false,
        "size":                "256Gi",
        "mode":                "disabled",
        "type":                "pvc",
        "runAsNonRoot":        false,
    }

    removeSpecificKeyValuesRecursive(config, specificKeyValues)
}

// removeSpecificKeyValuesRecursive recursively deletes specific key-value pairs from the config
func removeSpecificKeyValuesRecursive(config interface{}, specificKeyValues map[string]interface{}) {
    switch c := config.(type) {
    case map[string]interface{}:
        for key, value := range c {
            if expectedValue, ok := specificKeyValues[key]; ok {
                switch expectedValue := expectedValue.(type) {
                case float64:
                    if actualValue, ok := value.(float64); ok && actualValue == expectedValue {
                        delete(c, key)
                    }
                case string:
                    if actualValue, ok := value.(string); ok && actualValue == expectedValue {
                        delete(c, key)
                    }
                    // Add more cases for other types if needed
                }
            } else {
                removeSpecificKeyValuesRecursive(value, specificKeyValues)
            }
        }
    case []interface{}:
        for _, v := range c {
            removeSpecificKeyValuesRecursive(v, specificKeyValues)
        }
    }
}

// deleteNestedKeyRecursive recursively deletes a nested key in config based on a dot-separated key path
func deleteNestedKeyRecursive(config map[string]interface{}, keyPath string) {
    keys := strings.Split(keyPath, ": ")
    if len(keys) != 2 {
        return
    }

    key := strings.TrimSpace(keys[0])
    value := strings.TrimSpace(keys[1])

    if section, ok := config[key]; ok {
        if submap, ok := section.(map[string]interface{}); ok {
            if val, exists := submap[key]; exists {
                if val == value {
                    delete(submap, key)
                }
            }
        }
    }

    for _, v := range config {
        if subMap, ok := v.(map[string]interface{}); ok {
            deleteNestedKeyRecursive(subMap, keyPath)
        }
    }
}

// processVolsyncEntries ensures that if "src.enabled" is true, "dest.enabled" is also true in "volsync" entries
func processVolsyncEntries(config map[string]interface{}) {
    if persistence, ok := config["persistence"].(map[string]interface{}); ok {
        for _, value := range persistence {
            if volsync, ok := value.(map[string]interface{})["volsync"].(map[string]interface{}); ok {
                if src, ok := volsync["src"].(map[string]interface{}); ok {
                    if enabled, ok := src["enabled"].(bool); ok && enabled {
                        // TODO remove when we have snapshot compatible backend and are out of ALPHA
                        src["enabled"] = false
                        if dest, ok := volsync["dest"].(map[string]interface{}); ok {
                            // TODO: enable when we have a snapshot-compatible backend
                            dest["enabled"] = false
                        }
                    }
                }
            }
        }
    }
}

// GenerateHelmValuesFromJSON generates HelmRelease YAML from JSON configuration
func GenerateHelmValuesFromJSON(inputFile string, outputFile string) error {
    // Read JSON file
    jsonFile, err := os.Open(inputFile)
    if err != nil {
        return fmt.Errorf("failed to open JSON file: %w", err)
    }
    defer jsonFile.Close()

    byteValue, err := ioutil.ReadAll(jsonFile)
    if err != nil {
        return fmt.Errorf("failed to read JSON file: %w", err)
    }

    var radarrConfig RadarrConfig
    err = json.Unmarshal(byteValue, &radarrConfig)
    if err != nil {
        return fmt.Errorf("failed to unmarshal JSON: %w", err)
    }

    // Transformations and deletions
    removeKeysStartingWithIX(radarrConfig.Config)
    removeSpecificKeys(radarrConfig.Config)
    mergeLists(radarrConfig.Config)
    removeEmptyLists(radarrConfig.Config)

    radarrConfig.Namespace = removeIXPrefix(radarrConfig.Namespace)
    removePortalOpenDisabled(radarrConfig.Config)
    removeAdvancedSettings(radarrConfig.Config)
    removeSpecificKeyValues(radarrConfig.Config)
    removeEmptyDicts(radarrConfig.Config)
    processVolsyncEntries(radarrConfig.Config) // Add this line to call the new function

    // Populate HelmRelease structure
    helmRelease := fluxhandler.HelmRelease{
        APIVersion: "helm.toolkit.fluxcd.io/v2", // default value
        Kind:       "HelmRelease",               // default value
        Metadata: fluxhandler.Metadata{
            Name:      radarrConfig.Name,
            Namespace: radarrConfig.Namespace,
        },
        Spec: fluxhandler.Spec{
            Interval:    "15m",
            ReleaseName: radarrConfig.Name, // Assuming release name should be same as the chart name
            Chart: fluxhandler.Chart{
                Spec: fluxhandler.ChartSpec{
                    Chart:   radarrConfig.ChartMetadata["name"].(string),
                    Version: radarrConfig.ChartMetadata["version"].(string),
                    SourceRef: fluxhandler.SourceRef{
                        Kind:      "HelmRepository",
                        Name:      "truecharts",
                        Namespace: "flux-system",
                    },
                },
            },
            Values: radarrConfig.Config, // Dynamic configuration
        },
    }

    // Create directories if they do not exist
    outputDir := filepath.Dir(outputFile)
    err = os.MkdirAll(outputDir, 0755)
    if err != nil {
        return fmt.Errorf("failed to create directories: %w", err)
    }

    // Write YAML file
    yamlData, err := yaml.Marshal(&helmRelease)
    if err != nil {
        return fmt.Errorf("failed to marshal YAML: %w", err)
    }

    err = ioutil.WriteFile(outputFile, yamlData, 0644)
    if err != nil {
        return fmt.Errorf("failed to write YAML file: %w", err)
    }

    log.Info().Msg("HelmRelease YAML file created successfully")
    return nil
}

// GetJSONFilesFromDir returns a list of JSON files in a directory
func GetJSONFilesFromDir(dir string) ([]string, error) {
    var jsonFiles []string
    err := filepath.Walk(dir, func(path string, info os.FileInfo, err error) error {
        if err != nil {
            return err
        }
        if !info.IsDir() && strings.HasSuffix(info.Name(), ".json") {
            jsonFiles = append(jsonFiles, path)
        }
        return nil
    })
    if err != nil {
        return nil, fmt.Errorf("failed to walk directory: %w", err)
    }
    return jsonFiles, nil
}

// ProcessJSONFiles processes JSON files and generates HelmRelease YAML files
func ProcessJSONFiles(inputDir string) error {
    jsonFiles, err := GetJSONFilesFromDir(inputDir)
    if err != nil {
        return err
    }

    for _, jsonFile := range jsonFiles {
        // Read JSON file to get the release name
        jsonData, err := ioutil.ReadFile(jsonFile)
        if err != nil {
            return fmt.Errorf("failed to read JSON file %s: %w", jsonFile, err)
        }

        var radarrConfig RadarrConfig
        err = json.Unmarshal(jsonData, &radarrConfig)
        if err != nil {
            return fmt.Errorf("failed to unmarshal JSON from file %s: %w", jsonFile, err)
        }

        // Use release name for directory path
        outputDir := path.Join("./clusters/", helper.ClusterName, "/kubernetes/apps/", radarrConfig.Name, "/app/")

        // Ensure output directory exists
        err = os.MkdirAll(outputDir, 0755)
        if err != nil {
            return fmt.Errorf("failed to create directory %s: %w", outputDir, err)
        }

        outputFile := filepath.Join(outputDir, "helm-release.yaml")

        // Generate Helm values YAML
        err = GenerateHelmValuesFromJSON(jsonFile, outputFile)
        if err != nil {
            return fmt.Errorf("failed to generate Helm values from file %s: %w", jsonFile, err)
        }
    }

    return nil
}
