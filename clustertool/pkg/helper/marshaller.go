package helper

import (
    "bytes"

    "gopkg.in/yaml.v3"
)

func MarshalYaml(buf *bytes.Buffer, v interface{}) error {
    enc := yaml.NewEncoder(buf)
    defer enc.Close()
    enc.SetIndent(2)
    return enc.Encode(v)
}
