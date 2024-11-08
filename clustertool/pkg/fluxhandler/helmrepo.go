package fluxhandler

import (
    "io/ioutil"
    "path/filepath"
    "strings"

    "github.com/rs/zerolog/log"
    "gopkg.in/yaml.v3"
)

type HelmRepoMetadata struct {
    Name      string `yaml:"name,omitempty"`
    Namespace string `yaml:"namespace,omitempty"`
}

type HelmRepoSpec struct {
    Interval string `yaml:"interval,omitempty"`
    URL      string `yaml:"url,omitempty"`
}

type HelmRepo struct {
    Metadata HelmRepoMetadata `yaml:"metadata,omitempty"`
    Spec     HelmRepoSpec     `yaml:"spec,omitempty"`
}

// LoadAllHelmRepos loads all .yaml files under a directory into a map of HelmRepo structs,
// ignoring kustomize.yaml and logging errors without stopping the entire process.
func LoadAllHelmRepos(dirPath string) (map[string]*HelmRepo, error) {
    files, err := ioutil.ReadDir(dirPath)
    if err != nil {
        return nil, err
    }

    repos := make(map[string]*HelmRepo)

    for _, file := range files {
        if !file.IsDir() && strings.HasSuffix(file.Name(), ".yaml") {
            // Ignore kustomize.yaml file
            if file.Name() == "kustomize.yaml" {
                continue
            }
            filename := filepath.Join(dirPath, file.Name())
            repo, err := LoadHelmRepo(filename)
            if err != nil {
                // Log the error but continue processing other files
                log.Info().Msgf("Error loading repo from file %s: %v\n", file.Name(), err)
                continue
            }
            // Use metadata.name as the key in the map
            repos[repo.Metadata.Name] = repo
        }
    }

    return repos, nil
}

// LoadHelmRepo loads a single HelmRepo struct from a YAML file
func LoadHelmRepo(filename string) (*HelmRepo, error) {
    // Read YAML file
    yamlFile, err := ioutil.ReadFile(filename)
    if err != nil {
        return nil, err
    }

    // Initialize HelmRepo struct
    repo := &HelmRepo{}

    // Unmarshal YAML into struct
    err = yaml.Unmarshal(yamlFile, repo)
    if err != nil {
        return nil, err
    }

    return repo, nil
}
