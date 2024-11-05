package talassist

import (
    "io/ioutil"

    "github.com/truecharts/public/clustertool/pkg/helper"
    "sigs.k8s.io/yaml"
)

// NodeIPConfig represents a simplified YAML structure to only parse node IP addresses
type NodeIPConfig struct {
    Nodes []struct {
        IPAddress string `yaml:"ipAddress"`
    } `yaml:"nodes"`
}

// LoadNodeIPs loads the list of IP addresses in nodes[].ipAddress from talconfig.yaml
func LoadNodeIPs() error {
    // Read the YAML file
    data, err := ioutil.ReadFile(helper.TalConfigFile)
    if err != nil {
        return err
    }

    // Unmarshal only the IP addresses from the YAML
    var config NodeIPConfig
    if err := yaml.Unmarshal(data, &config); err != nil {
        return err
    }

    // Extract the IP addresses into a list
    for _, node := range config.Nodes {
        IpAddresses = append(IpAddresses, node.IPAddress)
    }

    return nil
}
