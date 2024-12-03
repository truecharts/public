package chartFile

import (
    "bytes"
    "fmt"
    "os"

    "github.com/go-playground/validator/v10"
    "github.com/truecharts/public/clustertool/pkg/helper"

    "github.com/knadh/koanf/parsers/yaml"
    "github.com/knadh/koanf/providers/file"
    "github.com/knadh/koanf/v2"
)

const (
    minHelmVersion     = "3.14"
    maxHelmVersion     = "3.16"
    kubeVersion        = ">=1.24.0-0"
    apiVersion         = "v2"
    chartType          = "application"
    maintainerName     = "TrueCharts"
    maintainerEmail    = "info@truecharts.org"
    maintainerURL      = "https://truecharts.org"
    defaultCategory    = "unsorted"
    defaultAppVersion  = "unknown"
    defaultDescription = "No description provided."
    defaultHome        = "https://truecharts.org"
    defaultIcon        = "https://github.com/truecharts/website/blob/main/static/svg/logo.svg"
)

var validate *validator.Validate

// Maintainer represents a maintainer of the Helm chart.
type Maintainer struct {
    Name  string `yaml:"name" validate:"required"`
    Email string `yaml:"email"`
    URL   string `yaml:"url" validate:"required"`
}

// Dependency represents a dependency of the Helm chart.
type Dependency struct {
    Name         string   `yaml:"name" validate:"required"`
    Version      string   `yaml:"version" validate:"required"`
    Repository   string   `yaml:"repository" validate:"required"`
    Condition    string   `yaml:"condition"`
    Alias        string   `yaml:"alias"`
    Tags         []string `yaml:"tags"`
    ImportValues []string `yaml:"import-values"`
}

// ChartMetadata represents the metadata structure in Chart.yaml.
type ChartMetadata struct {
    Annotations  map[string]string `yaml:"annotations"`
    APIVersion   string            `yaml:"apiVersion" validate:"required"`
    AppVersion   string            `yaml:"appVersion" validate:"required"`
    Dependencies []Dependency      `yaml:"dependencies"`
    Deprecated   bool              `yaml:"deprecated"`
    Description  string            `yaml:"description" validate:"required"`
    Home         string            `yaml:"home" validate:"required"`
    Icon         string            `yaml:"icon" validate:"required"`
    Keywords     []string          `yaml:"keywords"`
    KubeVersion  string            `yaml:"kubeVersion" validate:"required"`
    Maintainers  []Maintainer      `yaml:"maintainers" validate:"required,dive"`
    Name         string            `yaml:"name" validate:"required"`
    Sources      []string          `yaml:"sources"`
    Type         string            `yaml:"type"`
    Version      string            `yaml:"version" validate:"required"`
    // Add other fields as needed
}

// HelmChart represents the entire Chart.yaml structure.
type HelmChart struct {
    K        *koanf.Koanf
    Metadata ChartMetadata `yaml:"metadata" validate:"required,dive"`
    // Add other fields as needed
}

func NewHelmChart() *HelmChart {
    return &HelmChart{
        K: koanf.New("."),
    }
}

// LoadFromFile loads values from a YAML file into the HelmChart struct.
func (h *HelmChart) LoadFromFile(filename string) error {
    // Load YAML file using koanf
    if err := h.K.Load(file.Provider(filename), yaml.Parser()); err != nil {
        return fmt.Errorf("error loading from file %s: %v", filename, err)
    }

    // Unmarshal the data into the HelmChart struct
    if err := h.K.Unmarshal("", &h.Metadata); err != nil {
        return fmt.Errorf("error unmarshalling data: %v", err)
    }

    // Set default values for fields if they are not set or empty
    h.setDefaultValues()

    // Initialize validator
    validate = validator.New(validator.WithRequiredStructEnabled())

    if err := validate.Struct(h.Metadata); err != nil {
        return fmt.Errorf("chart.yaml validation error: %v", err)
    }

    return nil
}

// setDefaultValues sets default values for fields in ChartMetadata if they are not set or empty.
func (h *HelmChart) setDefaultValues() {
    h.setDeprecation()
    h.setApiVersion(apiVersion)
    h.setKubeVersion(kubeVersion)
    h.setType(chartType)
    h.setAppVersion(defaultAppVersion)
    h.setDescription(defaultDescription)
    h.setIcon(defaultIcon)
    h.setHome(defaultHome)

    h.setMaintainers(Maintainer{
        Name:  maintainerName,
        Email: maintainerEmail,
        URL:   maintainerURL,
    })

    // Make sure annotations is not nil
    if h.Metadata.Annotations == nil {
        h.Metadata.Annotations = make(map[string]string)
    }

    h.setAnnotation("truecharts.org/category", defaultCategory, false)
    h.setAnnotation("truecharts.org/min_helm_version", minHelmVersion, true)
    h.setAnnotation("truecharts.org/max_helm_version", maxHelmVersion, true)

    // Set default values for other fields as needed
}

// SaveToFile saves the Helm chart metadata back to the Chart.yaml file.
func (h *HelmChart) SaveToFile(filename string) error {

    // Initialize validator
    validate = validator.New(validator.WithRequiredStructEnabled())

    if err := validate.Struct(h.Metadata); err != nil {
        return fmt.Errorf("chart.yaml validation error: %v", err)
    }

    var configBytes bytes.Buffer
    err := helper.MarshalYaml(&configBytes, h.Metadata)
    if err != nil {
        return fmt.Errorf("error encoding data: %v", err)
    }

    // Write the configuration to the file using os.WriteFile
    err = os.WriteFile(filename, configBytes.Bytes(), 0644)
    if err != nil {
        return fmt.Errorf("error writing to file %s: %v", filename, err)
    }

    return nil
}

// setAnnotation sets the annotation key to value if it is not set or empty or force is true.
func (h *HelmChart) setAnnotation(key, value string, force bool) {
    if a, ok := h.Metadata.Annotations[key]; !ok || a == "" || force {
        h.Metadata.Annotations[key] = value
    }
}

// setDeprecation sets the deprecation field to false if it is not set.
func (h *HelmChart) setDeprecation() {
    if !h.Metadata.Deprecated {
        h.Metadata.Deprecated = false
    }
}

// setIcon sets the icon field to icon if it is not set or empty.
func (h *HelmChart) setIcon(icon string) {
    if h.Metadata.Icon == "" {
        h.Metadata.Icon = icon
    }
}

// setHome sets the home field to home if it is not set or empty.
func (h *HelmChart) setHome(home string) {
    if h.Metadata.Home == "" {
        h.Metadata.Home = home
    }
}

// setDescription sets the description field to description if it is not set or empty.
func (h *HelmChart) setDescription(description string) {
    if h.Metadata.Description == "" {
        h.Metadata.Description = description
    }
}

// setAppVersion sets the appVersion field to appVersion if it is not set or empty.
func (h *HelmChart) setAppVersion(appVersion string) {
    if h.Metadata.AppVersion == "" {
        h.Metadata.AppVersion = appVersion
    }
}

// setType sets the type field to cType if it is not set or empty.
func (h *HelmChart) setType(cType string) {
    if h.Metadata.Type == "" {
        h.Metadata.Type = cType
    }
}

// setApiVersion sets the apiVersion field to apiVersion
func (h *HelmChart) setApiVersion(apiVersion string) {
    h.Metadata.APIVersion = apiVersion
}

// setKubeVersion sets the kubeVersion field to kubeVersion
func (h *HelmChart) setKubeVersion(kubeVersion string) {
    h.Metadata.KubeVersion = kubeVersion
}

// setMaintainers sets the maintainers field to maintainers
func (h *HelmChart) setMaintainers(maintainers Maintainer) {
    h.Metadata.Maintainers = make([]Maintainer, 1)
    h.Metadata.Maintainers[0] = maintainers
}
