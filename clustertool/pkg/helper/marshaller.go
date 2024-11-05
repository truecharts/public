package helper

import (
    "bytes"
)

func MarshalYaml(buf *bytes.Buffer, v interface{}) error {
    enc := YamlNewEncoder(buf)
    enc.SetIndent(2)
    return enc.Encode(v)
}
