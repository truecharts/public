package helmunit

import (
    "github.com/Jeffail/gabs/v2"
    "sigs.k8s.io/yaml"
)

func mergeMaps(a, b map[string]interface{}) map[string]interface{} {
    out := make(map[string]interface{}, len(a))
    for k, v := range a {
        out[k] = v
    }
    for k, v := range b {
        if v, ok := v.(map[string]interface{}); ok {
            if bv, ok := out[k]; ok {
                if bv, ok := bv.(map[string]interface{}); ok {
                    out[k] = mergeMaps(bv, v)
                    continue
                }
            }
        }
        out[k] = v
    }
    return out
}

func yamlToJson(yamlInput []byte) (jsonOutput *gabs.Container, err error) {
    jsonBytes, err := yaml.YAMLToJSON(yamlInput)
    if err != nil {
        return nil, err
    }
    jsonParsed, err := gabs.ParseJSON(jsonBytes)
    if err != nil {
        return nil, err
    }
    return jsonParsed, nil
}
