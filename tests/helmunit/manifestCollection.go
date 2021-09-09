package helmunit

import (
    "errors"
    "strings"

    "github.com/Jeffail/gabs/v2"
)

type manifestCollection map[string]map[string]gabs.Container

func (c *manifestCollection) Initialize() {
    *c = make(manifestCollection)
}

func (c *manifestCollection) Add(yamlInput []byte) error {
    collection := *c
    jsonManifest, err := yamlToJson(yamlInput)
    if err != nil {
        return err
    }

    kind := strings.ToLower(jsonManifest.Path("kind").Data().(string))
    name := strings.ToLower(jsonManifest.Path("metadata.name").Data().(string))

    if kind == "" || name == "" {
        return errors.New("invalid manifest")
    }

    data, ok := collection[kind]
    if !ok {
        data = make(map[string]gabs.Container)
        collection[kind] = data
    }
    data[name] = *jsonManifest

    return nil
}

func (c *manifestCollection) Get(kind string, name string) *gabs.Container {
    collection := *c
    manifest, ok := collection[strings.ToLower(kind)][strings.ToLower(name)]
    if !ok {
        return nil
    }
    return &manifest
}
