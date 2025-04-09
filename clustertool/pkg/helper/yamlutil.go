package helper

import (
    "bytes"
    "io"

    "gopkg.in/yaml.v3"
)

// Encoder is a custom encoder for YAML that writes to an io.Writer.
type Encoder struct {
    writer io.Writer
    indent int
}

// NewEncoder creates a new Encoder that writes to the specified writer.
func YamlNewEncoder(w io.Writer) *Encoder {
    return &Encoder{writer: w}
}

// SetIndent sets the number of spaces for indentation.
func (e *Encoder) SetIndent(indent int) {
    e.indent = indent
}

// Encode encodes the value and writes it to the underlying writer with indentation.
func (e *Encoder) Encode(v interface{}) error {
    data, err := yaml.Marshal(v)
    if err != nil {
        return err
    }

    // If indent is set, format the output accordingly
    if e.indent > 0 {
        var indentedData bytes.Buffer
        for _, line := range bytes.Split(data, []byte{'\n'}) {
            if len(line) > 0 {
                indentedData.Write(bytes.Repeat([]byte{' '}, e.indent))
            }
            indentedData.Write(line)
            indentedData.WriteByte('\n')
        }
        data = indentedData.Bytes()
    }

    _, err = e.writer.Write(data)
    return err
}
