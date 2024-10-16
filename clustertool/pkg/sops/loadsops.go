package sops

import (
	"fmt"
	"io/ioutil"

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
	// Read .sops.yaml file
	data, err := ioutil.ReadFile(".sops.yaml")
	if err != nil {
		return SopsConfig{}, fmt.Errorf("error reading file: %v", err)
	}

	// Unmarshal YAML data into struct
	var config SopsConfig
	err = yaml.Unmarshal(data, &config)
	if err != nil {
		return SopsConfig{}, fmt.Errorf("error unmarshaling YAML: %v", err)
	}

	// Print the loaded struct
	// log.Info().Msgf("Loaded Config:\n%+v\n %v", config)
	return config, nil
}
