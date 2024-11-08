package sops

import (
    "fmt"
    "io/ioutil"
    "os"

    "github.com/rs/zerolog/log"
    "gopkg.in/yaml.v3"
)

type SopsConfig struct {
    CreationRules []struct {
        PathRegex      string `yaml:"path_regex"`
        EncryptedRegex string `yaml:"encrypted_regex,omitempty"`
        Age            string `yaml:"age"`
    } `yaml:"creation_rules"`
}

func LoadSopsConfig() (SopsConfig, error) {
    log.Trace().Msg("Starting LoadSopsConfig function")

    if _, err := os.Stat(".sops.yaml"); os.IsNotExist(err) {
        log.Info().Msg(".sops.yaml file does not exist, skipping loading SOPS....")
        return SopsConfig{}, fmt.Errorf("error reading file: %v", err)
    } else if err != nil {
        log.Error().Msgf("Error checking .sops.yaml file :", err)
    } else {
        log.Debug().Msg(".sops.yaml File exists.")
    }

    // Read .sops.yaml file
    data, err := ioutil.ReadFile(".sops.yaml")
    if err != nil {
        log.Error().Err(err).Msg("Error reading .sops.yaml file")
        return SopsConfig{}, fmt.Errorf("error reading file: %v", err)
    }
    log.Debug().Msg("Successfully read .sops.yaml file")

    // Unmarshal YAML data into struct
    var config SopsConfig
    err = yaml.Unmarshal(data, &config)
    if err != nil {
        log.Error().Err(err).Msg("Error unmarshaling YAML data")
        return SopsConfig{}, fmt.Errorf("error unmarshaling YAML: %v", err)
    }
    log.Debug().Msg("Successfully unmarshaled YAML data into struct")

    // Log the loaded struct
    log.Debug().Msg("Loaded SopsConfig successfully")
    log.Debug().Interface("loaded SOPS Config", config)

    return config, nil
}
