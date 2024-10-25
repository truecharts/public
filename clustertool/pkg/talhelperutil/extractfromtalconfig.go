package talhelperutil

import (
    "os"

    "github.com/rs/zerolog/log"

    "github.com/truecharts/public/clustertool/pkg/helper"
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
    log.Trace().Msg("Starting the ExtractIPs function")

    // Load YAML file
    file, err := os.ReadFile("config.yaml")
    if err != nil {
        log.Fatal().Err(err).Msg("Failed to read file: config.yaml")
    }
    log.Debug().Msg("Successfully read the YAML file")

    // Unmarshal YAML content into Config struct
    var config Config
    err = yaml.Unmarshal(file, &config)
    if err != nil {
        log.Fatal().Err(err).Msg("Failed to unmarshal YAML")
    }
    log.Debug().Msg("Successfully unmarshaled YAML into Config struct")

    // Reset the global variables to ensure they are empty before populating
    log.Info().Msg("Resetting global IP storage variables")
    helper.AllIPs = []string{}
    helper.ControlPlaneIPs = []string{}
    helper.WorkerIPs = []string{}

    // Loop through nodes to segregate IP addresses
    log.Debug().Msg("Looping through nodes to segregate IP addresses")
    for _, node := range config.Nodes {
        log.Debug().
            Str("hostname", node.Hostname).
            Str("ipAddress", node.IPAddress).
            Bool("controlPlane", node.ControlPlane).
            Msg("Processing node")

        helper.AllIPs = append(helper.AllIPs, node.IPAddress)
        if node.ControlPlane {
            helper.ControlPlaneIPs = append(helper.ControlPlaneIPs, node.IPAddress)
            log.Info().Str("ipAddress", node.IPAddress).Msg("Added to ControlPlaneIPs")
        } else {
            helper.WorkerIPs = append(helper.WorkerIPs, node.IPAddress)
            log.Info().Str("ipAddress", node.IPAddress).Msg("Added to WorkerIPs")
        }
    }

    log.Trace().Msg("Finished processing nodes")
    log.Info().Int("totalIPs", len(helper.AllIPs)).Msg("Total IPs extracted")
}
