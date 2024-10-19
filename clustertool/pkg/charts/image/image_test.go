package image

import (
    "fmt"
    "reflect"
    "testing"
)

func TestLoadValuesFile(t *testing.T) {
    type TestData struct {
        name       string
        valuesFile string
        expected   map[string]ImageDetails
        wantErr    bool
    }
    testDataPath := "../../testdata/values_yaml"
    tests := []TestData{
        {
            name:       "Test malformed file",
            valuesFile: "malformedValues.yaml",
            expected:   nil,
            wantErr:    true,
        },
        {
            name:       "Test empty file",
            valuesFile: "emptyValues.yaml",
            expected:   nil,
            wantErr:    false,
        },
        {
            name:       "Test single image file",
            valuesFile: "singleImageValues.yaml",
            expected: map[string]ImageDetails{
                "image": {
                    Repository: "nginx",
                    Tag:        "1.15.8",
                    Link:       "https://hub.docker.com/_/nginx",
                    Version:    "1.15.8",
                },
            },
        },
        {
            name:       "Test multiple image file",
            valuesFile: "multiImageValues.yaml",
            expected: map[string]ImageDetails{
                "image": {
                    Repository: "author/image",
                    Tag:        "1.0.0",
                    Link:       "https://hub.docker.com/r/author/image",
                    Version:    "1.0.0",
                },
                "dockerHub1Image": {
                    Repository: "docker.io/author/image",
                    Tag:        "1.0.0",
                    Link:       "https://hub.docker.com/r/author/image",
                    Version:    "1.0.0",
                },
                "dockerHub2Image": {
                    Repository: "index.docker.io/author/image",
                    Tag:        "1.0.0",
                    Link:       "https://hub.docker.com/r/author/image",
                    Version:    "1.0.0",
                },
                "dockerHub3Image": {
                    Repository: "registry-1.docker.io/author/image",
                    Tag:        "1.0.0",
                    Link:       "https://hub.docker.com/r/author/image",
                    Version:    "1.0.0",
                },
                "dockerHub4Image": {
                    Repository: "registry.hub.docker.com/author/image",
                    Tag:        "1.0.0",
                    Link:       "https://hub.docker.com/r/author/image",
                    Version:    "1.0.0",
                },
                "dockerHub5Image": {
                    Repository: "image",
                    Tag:        "1.0.0",
                    Link:       "https://hub.docker.com/_/image",
                    Version:    "1.0.0",
                },
                "dockerHub6Image": {
                    Repository: "library/image",
                    Tag:        "1.0.0",
                    Link:       "https://hub.docker.com/_/image",
                    Version:    "1.0.0",
                },
                "lscrImage": {
                    Repository: "lscr.io/linuxserver/image",
                    Tag:        "1.0.0",
                    Link:       "https://fleet.linuxserver.io/image?name=linuxserver/image",
                    Version:    "1.0.0",
                },
                "tccrImage": {
                    Repository: "tccr.io/tccr/image",
                    Tag:        "1.0.0",
                    Link:       "https://github.com/truecharts/containers/tree/master/apps/image",
                    Version:    "1.0.0",
                },
                "mcrImage": {
                    Repository: "mcr.microsoft.com/author/image",
                    Tag:        "1.0.0",
                    Link:       "https://mcr.microsoft.com/en-us/product/author/image",
                    Version:    "1.0.0",
                },
                "ecrImage": {
                    Repository: "public.ecr.aws/author/image",
                    Tag:        "1.0.0",
                    Link:       "https://gallery.ecr.aws/author/image",
                    Version:    "1.0.0",
                },
                "ghcrImage": {
                    Repository: "ghcr.io/author/image",
                    Tag:        "1.0.0",
                    Link:       "https://ghcr.io/author/image",
                    Version:    "1.0.0",
                },
                "quayImage": {
                    Repository: "quay.io/author/image",
                    Tag:        "1.0.0",
                    Link:       "https://quay.io/author/image",
                    Version:    "1.0.0",
                },
                "gcrImage": {
                    Repository: "gcr.io/author/image",
                    Tag:        "1.0.0",
                    Link:       "https://gcr.io/author/image",
                    Version:    "1.0.0",
                },
                "azurecrImage": {
                    Repository: "author.azurecr.io/image",
                    Tag:        "1.0.0",
                    Link:       "https://author.azurecr.io/image",
                    Version:    "1.0.0",
                },
                "ocirImage": {
                    Repository: "author.ocir.io/image",
                    Tag:        "1.0.0",
                    Link:       "",
                    Version:    "1.0.0",
                },
                "unknownImage": {
                    Repository: "unknown.io/author/image",
                    Tag:        "1.0.0",
                    Link:       "",
                    Version:    "1.0.0",
                },
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            var images Images
            err := images.LoadValuesFile(fmt.Sprintf("%s/%s", testDataPath, tt.valuesFile))
            if (err != nil) != tt.wantErr {
                t.Errorf("LoadValuesFile() error = %v, wantErr %v", err, tt.wantErr)
            }

            if tt.expected == nil && len(images.ImagesMap) > 0 {
                t.Errorf("LoadValuesFile() expected = %+v, got %+v", tt.expected, images.ImagesMap)
            }

            if tt.expected != nil {
                if !reflect.DeepEqual(images.ImagesMap, tt.expected) {
                    t.Errorf("LoadValuesFile() expected = %+v, got %+v", tt.expected, images.ImagesMap)
                }
            }
        })
    }
}
