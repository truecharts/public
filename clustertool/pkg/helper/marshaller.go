package helper

import (
    "bytes"
    "strings"

    "gopkg.in/yaml.v3"
)

func MarshalYaml(buf *bytes.Buffer, v interface{}) error {
    var tmpBuf bytes.Buffer
    enc := yaml.NewEncoder(&tmpBuf)
    enc.SetIndent(2)
    defer enc.Close()

    if err := enc.Encode(v); err != nil {
        return err
    }

    // Remove indent from top-level keys (lines that are not indented)
    lines := strings.Split(tmpBuf.String(), "\n")
    for _, line := range lines {
        if strings.HasPrefix(line, "  ") {
            buf.WriteString(line + "\n")
        } else {
            buf.WriteString(strings.TrimLeft(line, " ") + "\n")
        }
    }

    return nil
}
