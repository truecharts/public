package talhelperutil

import (
	"os"

	"github.com/rs/zerolog/log"

	"github.com/truecharts/private/clustertool/pkg/helper"
	"gopkg.in/yaml.v3"
)

// Node represents the structure of each node in the YAML file
type Node struct {
	Hostname     string `yaml:"hostname"`
	IPAddress    string `yaml:"ipAddress"`
	ControlPlane bool   `yaml:"controlPlane"`
}

// Config represents the structure of the YAML file
type Config struct {
	Nodes []Node `yaml:"nodes"`
}

func ExtractIPs() {
	// Load YAML file
	file, err := os.ReadFile("config.yaml")
	if err != nil {
		log.Fatal().Err(err).Msg("Failed to read file: %v")
	}

	// Unmarshal YAML content into Config struct
	var config Config
	err = yaml.Unmarshal(file, &config)
	if err != nil {
		log.Fatal().Err(err).Msg("Failed to unmarshal YAML: %v")
	}

	// Reset the global variables to ensure they are empty before populating
	helper.AllIPs = []string{}
	helper.ControlPlaneIPs = []string{}
	helper.WorkerIPs = []string{}

	// Loop through nodes to segregate IP addresses
	for _, node := range config.Nodes {
		helper.AllIPs = append(helper.AllIPs, node.IPAddress)
		if node.ControlPlane {
			helper.ControlPlaneIPs = append(helper.ControlPlaneIPs, node.IPAddress)
		} else {
			helper.WorkerIPs = append(helper.WorkerIPs, node.IPAddress)
		}
	}
}
