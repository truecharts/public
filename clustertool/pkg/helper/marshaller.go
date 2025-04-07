package helper

import (
    "bytes"
)

func MarshalYaml(buf *bytes.Buffer, v interface{}) error {
    enc := YamlNewEncoder(buf)
    return enc.Encode(v)
}
