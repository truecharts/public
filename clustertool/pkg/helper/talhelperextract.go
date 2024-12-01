package helper

import (
    "path"
    "strings"

    "gopkg.in/yaml.v3"
)

// Node represents a node structure in the YAML file.
type Node struct {
    Hostname  string `yaml:"hostname"`
    IPAddress string `yaml:"ipAddress"`
}

// Config represents the top-level structure of the YAML file.
type Config struct {
    Nodes []Node `yaml:"nodes"`
}

func ExtractNode(cmd string) string {
    sliceOut := strings.Split(cmd, " ")
    nodeout := ""

    for i, str := range sliceOut {
        if strings.HasPrefix(str, "--nodes=") {
            nodeout = strings.TrimPrefix(str, "--nodes=")
            break
        }
        if str == "-n" && i+1 < len(sliceOut) {
            nodeout = sliceOut[i+1]
            break
        }
    }

    return nodeout
}
func ExtractSchematic(cmd string) string {
    sliceOut := strings.Split(string(cmd), " ")
    schematic := ""

    for _, str := range sliceOut {
        if strings.Contains(str, "--image=") {
            cleanstring := strings.ReplaceAll(str, "--image=factory.talos.dev/installer/", "")
            schemslice := strings.Split(string(cleanstring), ":")
            schematic = schemslice[0]
        }
    }
    return string(schematic)
}

// CreateIPHostnameMap reads the YAML configuration file and returns a map of ipAddress to hostname.
func CreateIPHostnameMap() (map[string]string, error) {
    // Read the YAML file.
    data, err := EnvSubst(path.Join(ClusterPath, "/talos/talconfig.yaml"), TalEnv)

    if err != nil {
        return nil, err
    }

    // Convert the string data to bytes.
    dataBytes := []byte(data)

    // Unmarshal the YAML file into a Config struct.
    var config Config
    err = yaml.Unmarshal(dataBytes, &config)
    if err != nil {
        return nil, err
    }

    // Create the map of ipAddress to hostname.
    ipHostnameMap := make(map[string]string)
    for _, node := range config.Nodes {
        ipHostnameMap[node.IPAddress] = node.Hostname
    }

    return ipHostnameMap, nil
}
