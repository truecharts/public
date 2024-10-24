package fluxhandler

import (
    "fmt"
    "io/ioutil"
    "os"
    "path/filepath"
    "strings"
    "sync"

    "github.com/rs/zerolog/log"
    "gopkg.in/yaml.v3"
)

type HelmChart struct {
    ChartPath string
    Retry     bool
    Wait      bool
}

type SourceRef struct {
    Kind      string `yaml:"kind,omitempty"`
    Name      string `yaml:"name,omitempty"`
    Namespace string `yaml:"namespace,omitempty"`
}

type ChartSpec struct {
    Chart     string    `yaml:"chart,omitempty"`
    Version   string    `yaml:"version,omitempty"`
    SourceRef SourceRef `yaml:"sourceRef,omitempty"`
}

type Chart struct {
    Spec ChartSpec `yaml:"spec,omitempty"`
}

type Spec struct {
    Interval    string                 `yaml:"interval,omitempty"`
    Chart       Chart                  `yaml:"chart,omitempty"`
    ReleaseName string                 `yaml:"releaseName,omitempty"`
    Values      map[string]interface{} `yaml:"values,omitempty"`
}

type Metadata struct {
    Name      string `yaml:"name,omitempty"`
    Namespace string `yaml:"namespace,omitempty"`
}

type HelmRelease struct {
    APIVersion string   `yaml:"apiVersion"`
    Kind       string   `yaml:"kind"`
    Metadata   Metadata `yaml:"metadata,omitempty"`
    Spec       Spec     `yaml:"spec,omitempty"`
}

func LoadHelmRelease(filename string) (*HelmRelease, error) {
    // Read YAML file
    yamlFile, err := ioutil.ReadFile(filename)
    if err != nil {
        return nil, fmt.Errorf("failed to read file: %w", err)
    }

    // Initialize HelmRelease struct
    config := &HelmRelease{}

    // Unmarshal YAML into struct
    err = yaml.Unmarshal(yamlFile, config)
    if err != nil {
        return nil, fmt.Errorf("failed to unmarshal YAML: %w", err)
    }

    // Ensure Values is not nil
    if config.Spec.Values == nil {
        config.Spec.Values = make(map[string]interface{})
    }
    return config, nil
}

func InstallCharts(charts []HelmChart, HelmRepos map[string]*HelmRepo, async bool) {
    var wg sync.WaitGroup
    for _, chart := range charts {
        wg.Add(1)
        go func(chart HelmChart) {
            defer wg.Done()
            valuesFile := filepath.Join(chart.ChartPath, "values.yaml")
            helmreleaseFile := filepath.Join(chart.ChartPath, "helm-release.yaml")
            helmRelease, err := LoadHelmRelease(helmreleaseFile)
            if err != nil {
                log.Info().Msgf("ERROR LOADING helmRelease for:  %v", chart)
                os.Exit(1)
            }
            if helmRelease == nil {
                log.Info().Msgf("ERROR Empty helmRelease for:  %v", chart)
                os.Exit(1)
            }

            releaseName := helmRelease.Metadata.Name
            if helmRelease.Spec.ReleaseName != "" {
                releaseName = helmRelease.Spec.ReleaseName
            }

            if HelmRepos[helmRelease.Spec.Chart.Spec.SourceRef.Name] == nil {
                log.Info().Msgf("ERROR Empty helmRepo for: ", helmRelease.Spec.Chart.Spec.SourceRef.Name)
                os.Exit(1)
            }

            if HelmRepos[helmRelease.Spec.Chart.Spec.SourceRef.Name].Spec.URL == "" {
                log.Info().Msgf("ERROR Empty repoURL for: ", helmRelease.Spec.Chart.Spec.SourceRef.Name)
                os.Exit(1)
            }

            log.Info().Msgf("Bootstrap: Installing %s\n", helmRelease.Metadata.Name)
            // We need to split install from dependency downloading, so we can parallel downloading
            if err := HelmInstall(HelmRepos[helmRelease.Spec.Chart.Spec.SourceRef.Name].Spec.URL, helmRelease.Spec.Chart.Spec.Chart, releaseName, helmRelease.Metadata.Namespace, valuesFile, helmRelease.Spec.Chart.Spec.Version, chart.Retry, chart.Wait, true); err != nil {
                if strings.Contains(err.Error(), "webhook") {
                } else {
                    log.Error().Err(err).Msgf("Error: %v\n", err)

                    if !async {
                        os.Exit(1)
                    }
                }
            }
        }(chart)
        if !async {
            wg.Wait()
        }
    }
    if async {
        wg.Wait()
    }
}

// UpgradeCharts upgrades Helm releases with provided Helm charts and repositories
func UpgradeCharts(charts []HelmChart, HelmRepos map[string]*HelmRepo, async bool) {
    var wg sync.WaitGroup
    for _, chart := range charts {
        wg.Add(1)
        go func(chart HelmChart) {
            defer wg.Done()

            // Determine paths
            valuesFile := filepath.Join(chart.ChartPath, "values.yaml")
            helmreleaseFile := filepath.Join(chart.ChartPath, "helm-release.yaml")

            // Load Helm release
            helmRelease, err := LoadHelmRelease(helmreleaseFile)
            if err != nil {
                log.Error().Err(err).Msgf("Error loading Helm release for chart at %s: %v\n", chart.ChartPath)

                if !async {
                    os.Exit(1)
                }
                return
            }
            if helmRelease == nil {
                log.Error().Msgf("Empty Helm release for chart at %s\n", chart.ChartPath)

                if !async {
                    os.Exit(1)
                }
                return
            }

            // Determine release name
            releaseName := helmRelease.Metadata.Name
            if helmRelease.Spec.ReleaseName != "" {
                releaseName = helmRelease.Spec.ReleaseName
            }

            // Determine chart name
            chartName := helmRelease.Spec.Chart.Spec.Chart

            // Validate Helm repository
            repoName := helmRelease.Spec.Chart.Spec.SourceRef.Name
            repo, ok := HelmRepos[repoName]
            if !ok || repo.Spec.URL == "" {
                log.Error().Msgf("Empty or invalid Helm repository for %s\n", repoName)

                if !async {
                    os.Exit(1)
                }
                return
            }

            // Perform Helm upgrade
            log.Info().Msgf("Upgrading %s\n", helmRelease.Metadata.Name)
            err = HelmUpgrade(repo.Spec.URL, chartName, releaseName, helmRelease.Metadata.Namespace, valuesFile, helmRelease.Spec.Chart.Spec.Version, chart.Wait, true)
            if err != nil {
                log.Error().Err(err).Msgf("Error upgrading %s\n", helmRelease.Metadata.Name)

                if !async {
                    os.Exit(1)
                }
                return
            }
        }(chart)

        if !async {
            wg.Wait()
        }
    }

    if async {
        wg.Wait()
    }
}
