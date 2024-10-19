package chartFile

import (
    "fmt"
    "reflect"
    "testing"
)

func TestSetAnnotation(t *testing.T) {
    type args struct {
        key   string
        value string
        force bool
    }

    type testData struct {
        name    string
        data    args
        initial map[string]string
        want    map[string]string
    }

    tests := []testData{
        {
            name:    "Should set annotation when not present",
            initial: map[string]string{},
            want: map[string]string{
                "test": "test",
            },
            data: args{
                key:   "test",
                value: "test",
                force: false,
            },
        },
        {
            name: "Should not set annotation when present and force is false",
            initial: map[string]string{
                "test": "value",
            },
            want: map[string]string{
                "test": "value",
            },
            data: args{
                key:   "test",
                value: "test",
                force: false,
            },
        },
        {
            name: "Should set annotation when present and force is true",
            initial: map[string]string{
                "test": "value",
            },
            want: map[string]string{
                "test": "test",
            },
            data: args{
                key:   "test",
                value: "test",
                force: true,
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            h.Metadata.Annotations = tt.initial

            h.setAnnotation(tt.data.key, tt.data.value, tt.data.force)

            if !reflect.DeepEqual(h.Metadata.Annotations, tt.want) {
                t.Errorf("%s - Annotations, got %v, want %v", tt.name, h.Metadata.Annotations, tt.want)
            }
        })
    }
}

func TestSetDeprecation(t *testing.T) {
    type testData struct {
        name  string
        input ChartMetadata
        want  ChartMetadata
    }

    tests := []testData{
        {
            name: "Should set deprecation to false when not present",
            input: ChartMetadata{
                Deprecated: false,
            },
            want: ChartMetadata{
                Deprecated: false,
            },
        },
        {
            name: "Should not set deprecation when present",
            input: ChartMetadata{
                Deprecated: true,
            },
            want: ChartMetadata{
                Deprecated: true,
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            h.Metadata = tt.input

            h.setDeprecation()

            if !reflect.DeepEqual(h.Metadata, tt.want) {
                t.Errorf("%s - Metadata, got %v, want %v", tt.name, h.Metadata, tt.want)
            }
        })
    }

}

type TestData struct {
    name    string
    value   string
    initial ChartMetadata
    want    ChartMetadata
}

func TestSetIcon(t *testing.T) {
    tests := []TestData{
        {
            name:  "Should set icon when not present",
            value: "test",
            initial: ChartMetadata{
                Icon: "",
            },
            want: ChartMetadata{
                Icon: "test",
            },
        },
        {
            name:  "Should not set icon when present",
            value: "test",
            initial: ChartMetadata{
                Icon: "some-icon",
            },
            want: ChartMetadata{
                Icon: "some-icon",
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            h.Metadata = tt.initial

            h.setIcon(tt.value)

            if !reflect.DeepEqual(h.Metadata, tt.want) {
                t.Errorf("%s - Metadata, got %v, want %v", tt.name, h.Metadata, tt.want)
            }
        })
    }
}

func TestSetHome(t *testing.T) {
    tests := []TestData{
        {
            name:  "Should set home when not present",
            value: "test",
            initial: ChartMetadata{
                Home: "",
            },
            want: ChartMetadata{
                Home: "test",
            },
        },
        {
            name:  "Should not set home when present",
            value: "test",
            initial: ChartMetadata{
                Home: "some-home",
            },
            want: ChartMetadata{
                Home: "some-home",
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            h.Metadata = tt.initial

            h.setHome(tt.value)

            if !reflect.DeepEqual(h.Metadata, tt.want) {
                t.Errorf("%s - Metadata, got %v, want %v", tt.name, h.Metadata, tt.want)
            }
        })
    }
}

func TestSetDescription(t *testing.T) {
    tests := []TestData{
        {
            name:  "Should set description when not present",
            value: "test",
            initial: ChartMetadata{
                Description: "",
            },
            want: ChartMetadata{
                Description: "test",
            },
        },
        {
            name:  "Should not set description when present",
            value: "test",
            initial: ChartMetadata{
                Description: "some-description",
            },
            want: ChartMetadata{
                Description: "some-description",
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            h.Metadata = tt.initial

            h.setDescription(tt.value)

            if !reflect.DeepEqual(h.Metadata, tt.want) {
                t.Errorf("%s - Metadata, got %v, want %v", tt.name, h.Metadata, tt.want)
            }
        })
    }
}

func TestSetAppVersion(t *testing.T) {
    tests := []TestData{
        {
            name:  "Should set appVersion when not present",
            value: "test",
            initial: ChartMetadata{
                AppVersion: "",
            },
            want: ChartMetadata{
                AppVersion: "test",
            },
        },
        {
            name:  "Should not set appVersion when present",
            value: "test",
            initial: ChartMetadata{
                AppVersion: "some-appVersion",
            },
            want: ChartMetadata{
                AppVersion: "some-appVersion",
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            h.Metadata = tt.initial

            h.setAppVersion(tt.value)

            if !reflect.DeepEqual(h.Metadata, tt.want) {
                t.Errorf("%s - Metadata, got %v, want %v", tt.name, h.Metadata, tt.want)
            }
        })
    }
}

func TestSetType(t *testing.T) {
    tests := []TestData{
        {
            name:  "Should set type when not present",
            value: "test",
            initial: ChartMetadata{
                Type: "",
            },
            want: ChartMetadata{
                Type: "test",
            },
        },
        {
            name:  "Should not set type when present",
            value: "test",
            initial: ChartMetadata{
                Type: "some-type",
            },
            want: ChartMetadata{
                Type: "some-type",
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            h.Metadata = tt.initial

            h.setType(tt.value)

            if !reflect.DeepEqual(h.Metadata, tt.want) {
                t.Errorf("%s - Metadata, got %v, want %v", tt.name, h.Metadata, tt.want)
            }
        })
    }
}

func TestSetApiVersion(t *testing.T) {
    tests := []TestData{
        {
            name:  "Should set apiVersion when not present",
            value: "test",
            initial: ChartMetadata{
                APIVersion: "",
            },
            want: ChartMetadata{
                APIVersion: "test",
            },
        },
        {
            name:  "Should always set apiVersion when present",
            value: "test",
            initial: ChartMetadata{
                APIVersion: "some-apiVersion",
            },
            want: ChartMetadata{
                APIVersion: "test",
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            h.Metadata = tt.initial

            h.setApiVersion(tt.value)

            if !reflect.DeepEqual(h.Metadata, tt.want) {
                t.Errorf("%s - Metadata, got %v, want %v", tt.name, h.Metadata, tt.want)
            }
        })
    }
}

func TestSetKubeVersion(t *testing.T) {
    tests := []TestData{
        {
            name:  "Should set kubeVersion when not present",
            value: "test",
            initial: ChartMetadata{
                KubeVersion: "",
            },
            want: ChartMetadata{
                KubeVersion: "test",
            },
        },
        {
            name:  "Should always set kubeVersion when present",
            value: "test",
            initial: ChartMetadata{
                KubeVersion: "some-kubeVersion",
            },
            want: ChartMetadata{
                KubeVersion: "test",
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            h.Metadata = tt.initial

            h.setKubeVersion(tt.value)

            if !reflect.DeepEqual(h.Metadata, tt.want) {
                t.Errorf("%s - Metadata, got %v, want %v", tt.name, h.Metadata, tt.want)
            }
        })
    }
}

func TestSetMaintainers(t *testing.T) {
    type testData struct {
        name    string
        value   Maintainer
        initial ChartMetadata
        want    ChartMetadata
    }
    tests := []testData{
        {
            name: "Should set maintainers when not present",
            value: Maintainer{
                Name:  "test-name",
                Email: "test-mail",
                URL:   "test-url",
            },
            initial: ChartMetadata{
                Maintainers: []Maintainer{},
            },
            want: ChartMetadata{
                Maintainers: []Maintainer{
                    {
                        Name:  "test-name",
                        Email: "test-mail",
                        URL:   "test-url",
                    },
                },
            },
        },
        {
            name: "Should always set maintainers when present",
            value: Maintainer{
                Name:  "test-name",
                Email: "test-mail",
                URL:   "test-url",
            },
            initial: ChartMetadata{
                Maintainers: []Maintainer{
                    {
                        Name:  "some-maintainer",
                        Email: "some-mail",
                        URL:   "some-url",
                    },
                },
            },
            want: ChartMetadata{
                Maintainers: []Maintainer{
                    {
                        Name:  "test-name",
                        Email: "test-mail",
                        URL:   "test-url",
                    },
                },
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {

            h := NewHelmChart()
            h.Metadata = tt.initial

            h.setMaintainers(tt.value)

            if !reflect.DeepEqual(h.Metadata.Maintainers, tt.want.Maintainers) {
                t.Errorf("%s - Maintainers, got %v, want %v", tt.name, h.Metadata.Maintainers, tt.want.Maintainers)
            }
        })
    }
}

func TestSetDefaults(t *testing.T) {
    type testData struct {
        name    string
        initial ChartMetadata
        want    ChartMetadata
    }
    tests := []testData{
        {
            name:    "Should set defaults",
            initial: ChartMetadata{},
            want: ChartMetadata{
                KubeVersion: kubeVersion,
                APIVersion:  apiVersion,
                Type:        chartType,
                Deprecated:  false,
                AppVersion:  defaultAppVersion,
                Description: defaultDescription,
                Home:        defaultHome,
                Icon:        defaultIcon,
                Maintainers: []Maintainer{
                    {
                        Name:  maintainerName,
                        Email: maintainerEmail,
                        URL:   maintainerURL,
                    },
                },
                Annotations: map[string]string{
                    "truecharts.org/category":         defaultCategory,
                    "truecharts.org/min_helm_version": minHelmVersion,
                    "truecharts.org/max_helm_version": maxHelmVersion,
                },
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {

            h := NewHelmChart()
            h.Metadata = tt.initial

            h.setDefaultValues()

            if !reflect.DeepEqual(h.Metadata, tt.want) {
                t.Errorf("%s - Metadata, got %v, want %v", tt.name, h.Metadata, tt.want)
            }
        })
    }

}

func TestLoadFromFile(t *testing.T) {
    type testData struct {
        name    string
        file    string
        wantErr bool
    }

    testDataPath := "../../testdata/chart_yaml"
    tests := []testData{
        {
            name:    "Should load from file",
            file:    "validChart.yaml",
            wantErr: false,
        },
        {
            name:    "Should fail to load from malformed file",
            file:    "malformedChart.yaml",
            wantErr: true,
        },
        {
            name:    "Should fail to load from missing file",
            file:    "missingChart.yaml",
            wantErr: true,
        },
        {
            name:    "Should fail to load from invalid file",
            file:    "invalidChart.yaml",
            wantErr: true,
        },
        {
            name:    "Should fail to load from unmashalable file",
            file:    "unmarshalableChart.yaml",
            wantErr: true,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()

            err := h.LoadFromFile(fmt.Sprintf("%s/%s", testDataPath, tt.file))
            if (err != nil) != tt.wantErr {
                t.Errorf("%s - LoadFromFile() error = %v, wantErr %v", tt.name, err, tt.wantErr)
            }
        })
    }
}

func TestSaveToFile(t *testing.T) {
    type testData struct {
        name         string
        inFile       string
        outFile      string
        mutatedData  ChartMetadata
        shouldMutate bool
        wantErr      bool
    }

    testDataPath := "../../testdata/chart_yaml"
    tests := []testData{
        {
            name:         "Should fail to save to file",
            inFile:       "validChart.yaml",
            outFile:      "/tmp/test.yaml",
            mutatedData:  ChartMetadata{},
            shouldMutate: true,
            wantErr:      true,
        },
        {
            name:         "Should save to file",
            inFile:       "validChart.yaml",
            outFile:      "/tmp/test.yaml",
            mutatedData:  ChartMetadata{},
            shouldMutate: false,
            wantErr:      false,
        },
        {
            name:         "Should fail to write to file",
            inFile:       "validChart.yaml",
            outFile:      "/non-existent-dir/test.yaml",
            mutatedData:  ChartMetadata{},
            shouldMutate: false,
            wantErr:      true,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            h := NewHelmChart()
            if err := h.LoadFromFile(fmt.Sprintf("%s/%s", testDataPath, tt.inFile)); err != nil {
                t.Errorf("%s - LoadFromFile() error = %v", tt.name, err)
            }

            if tt.shouldMutate {
                h.Metadata = tt.mutatedData
            }

            err := h.SaveToFile(tt.outFile)
            if (err != nil) != tt.wantErr {
                t.Errorf("%s - SaveToFile() error = %v, wantErr %v", tt.name, err, tt.wantErr)
            }
        })
    }
}
