package chartFile

import (
    "reflect"
    "testing"

    "github.com/truecharts/public/clustertool/pkg/charts/image"
)

func TestSetAppVersionFromImage(t *testing.T) {
    type TestData struct {
        chart  *HelmChart
        image  *image.Images
        key    string
        result string
    }

    tests := []TestData{
        {
            chart: &HelmChart{
                Metadata: ChartMetadata{
                    AppVersion: "1.0.0",
                },
            },
            image: &image.Images{
                ImagesMap: map[string]image.ImageDetails{
                    "image": {
                        Repository: "nginx",
                        Tag:        "1.15.8",
                        Link:       "https://hub.docker.com/_/nginx",
                        Version:    "1.15.8",
                    },
                },
            },
            key:    "image",
            result: "1.15.8",
        },
        {
            chart: &HelmChart{
                Metadata: ChartMetadata{
                    AppVersion: "1.0.0",
                },
            },
            image: &image.Images{
                ImagesMap: map[string]image.ImageDetails{
                    "image": {
                        Repository: "nginx",
                        Tag:        "1.15.8",
                        Link:       "https://hub.docker.com/_/nginx",
                        Version:    "1.15.8",
                    },
                },
            },
            key:    "nonexistent",
            result: "1.0.0",
        },
    }

    for _, tt := range tests {
        setAppVersionFromImage(tt.chart, tt.image, tt.key)
        if tt.chart.Metadata.AppVersion != tt.result {
            t.Errorf("Expected %s, got %s", tt.result, tt.chart.Metadata.AppVersion)
        }
    }
}
func TestGetTrain(t *testing.T) {
    type TestData struct {
        name      string
        chart     *HelmChart
        chartPath string
        result    string
    }

    tests := []TestData{
        {
            name: "Test get train from path",
            chart: &HelmChart{
                Metadata: ChartMetadata{
                    Name: "test-chart",
                    Annotations: map[string]string{
                        "truecharts.org/train": "express",
                    },
                },
            },
            chartPath: "../../testdata/updater/stable/my-app/Chart.yaml",
            result:    "stable",
        },
        {
            name: "Test get train from annotations as fallback",
            chart: &HelmChart{
                Metadata: ChartMetadata{
                    Name: "test-chart",
                    Annotations: map[string]string{
                        "truecharts.org/train": "dev",
                    },
                },
            },
            // Too short path, cant detect train from path
            // so we should fallback to annotations
            chartPath: "my-app/Chart.yaml",
            result:    "dev",
        },
        {
            name: "Test failing to get train from path or annotations",
            chart: &HelmChart{
                Metadata: ChartMetadata{
                    Name:        "test-chart",
                    Annotations: map[string]string{},
                },
            },
            // Too short path, cant detect train from path
            // so we should fallback to annotations
            chartPath: "my-app/Chart.yaml",
            result:    "unknown",
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            train := GetTrain(tt.chartPath, tt.chart)

            if train != tt.result {
                t.Errorf("Expected train to be %s, but got %s", tt.result, train)
            }
        })
    }
}

func TestSetMetadata(t *testing.T) {
    type TestData struct {
        chart    *HelmChart
        train    string
        expected *HelmChart
    }

    tests := []TestData{
        {
            chart: &HelmChart{
                Metadata: ChartMetadata{
                    Name:        "test-chart",
                    Annotations: map[string]string{},
                },
            },
            train: "stable",
            expected: &HelmChart{
                Metadata: ChartMetadata{
                    Name: "test-chart",
                    Annotations: map[string]string{
                        "truecharts.org/train": "stable",
                    },
                    Icon: "https://truecharts.org/img/hotlink-ok/chart-icons/test-chart.webp",
                    Home: "https://truecharts.org/charts/stable/test-chart",
                },
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.chart.Metadata.Name, func(t *testing.T) {
            setMetadata(tt.chart, tt.train)

            if !reflect.DeepEqual(tt.chart, tt.expected) {
                t.Errorf("Expected chart to be %v, but got %v", tt.expected, tt.chart)
            }
        })
    }
}

func TestUpdateSources(t *testing.T) {
    type TestData struct {
        name       string
        chart      *HelmChart
        train      string
        imageLinks []string
        expected   []string
    }

    tests := []TestData{
        {
            name: "Test update sources",
            chart: &HelmChart{
                Metadata: ChartMetadata{
                    Name: "test-chart",
                    Sources: []string{
                        "",
                        "https://ghcr/truecharts/some-chart",
                        "https://docker.io/truecharts/some-chart",
                        "https://hub.docker/truecharts/some-chart",
                        "https://fleet.linuxserver/truecharts/some-chart",
                        "https://mcr.microsoft/truecharts/some-chart",
                        "https://github.com/truecharts/some-chart",
                        "https://gallery.ecr.aws/truecharts/some-chart",
                        "https://gcr/truecharts/some-chart",
                        "https://quay/truecharts/some-chart",
                        "http://truecharts/some-chart",
                        "https://truecharts.azurecr.io/some-chart",
                        "https://truecharts.ocir.io/some-chart",
                        "https://unrelated.com/some-chart",
                        "https://unrelated.com/some-chart",
                        "https://cr.hotio.dev/truecharts/some-chart",
                    },
                },
            },
            train: "stable",
            imageLinks: []string{
                "",
                "https://hub.docker.com/_/nginx",
                "https://quay.io/truecharts/test-chart",
            },
            expected: []string{
                "https://github.com/truecharts/charts/tree/master/charts/stable/test-chart",
                "https://hub.docker.com/_/nginx",
                "https://quay.io/truecharts/test-chart",
                "https://unrelated.com/some-chart",
            },
        },
    }

    for _, tt := range tests {
        t.Run(tt.chart.Metadata.Name, func(t *testing.T) {
            if err := updateSources(tt.chart, tt.train, tt.imageLinks); err != nil {
                t.Errorf("Expected no error, but got %v", err)
            }

            if !reflect.DeepEqual(tt.chart.Metadata.Sources, tt.expected) {
                t.Errorf("Expected chart to be %v, but got %v", tt.expected, tt.chart.Metadata.Sources)
            }
        })
    }
}
