package common

import (
    "testing"

    "github.com/truecharts/apps/tests/helmunit"
    "github.com/stretchr/testify/suite"
)

type HorizontalPodAutoscalerTestSuite struct {
    suite.Suite
    Chart helmunit.HelmChart
}

func (suite *HorizontalPodAutoscalerTestSuite) SetupSuite() {
    suite.Chart = helmunit.New("common-test", "../../common-test")
    suite.Chart.UpdateDependencies()
}

// We need this function to kick off the test suite, otherwise
// "go test" won't know about our tests
func TestHorizontalPodAutoscaler(t *testing.T) {
    suite.Run(t, new(HorizontalPodAutoscalerTestSuite))
}

func (suite *HorizontalPodAutoscalerTestSuite) TestValues() {
    baseValues := []string{"autoscaling.enabled=true"}
    tests := map[string]struct {
        values                          []string
        expectedHorizontalPodAutoscaler bool
        expectedTarget                  string
        expectedMinReplicas             int
        expectedMaxReplicas             int
    }{
        "Default": {
            values:                          nil,
            expectedHorizontalPodAutoscaler: false,
        },
        "Enabled": {
            values:                          baseValues,
            expectedHorizontalPodAutoscaler: true, expectedTarget: "common-test", expectedMinReplicas: 1, expectedMaxReplicas: 3,
        },
        "CustomSettings": {
            values:                          append(baseValues, "autoscaling.target=common-custom", "autoscaling.minReplicas=4", "autoscaling.maxReplicas=8"),
            expectedHorizontalPodAutoscaler: true, expectedTarget: "common-custom", expectedMinReplicas: 4, expectedMaxReplicas: 8,
        },
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            manifest := suite.Chart.Manifests.Get("HorizontalPodAutoscaler", "common-test")
            if tc.expectedHorizontalPodAutoscaler {
                suite.Assertions.NotEmpty(manifest)
                suite.Assertions.EqualValues(tc.expectedTarget, manifest.Path("spec.scaleTargetRef.name").Data())
                suite.Assertions.EqualValues(tc.expectedMinReplicas, manifest.Path("spec.minReplicas").Data())
                suite.Assertions.EqualValues(tc.expectedMaxReplicas, manifest.Path("spec.maxReplicas").Data())
            } else {
                suite.Assertions.Empty(manifest)
            }
        })
    }
}

func (suite *HorizontalPodAutoscalerTestSuite) TestMetrics() {
    baseValues := []string{"autoscaling.enabled=true"}
    tests := map[string]struct {
        values            []string
        expectedResources map[string]int
    }{
        "targetCPUUtilizationPercentage": {
            values:            append(baseValues, "autoscaling.targetCPUUtilizationPercentage=60"),
            expectedResources: map[string]int{"cpu": 60},
        },
        "targetMemoryUtilizationPercentage": {
            values:            append(baseValues, "autoscaling.targetMemoryUtilizationPercentage=70"),
            expectedResources: map[string]int{"memory": 70},
        },
        "Combined": {
            values:            append(baseValues, "autoscaling.targetCPUUtilizationPercentage=60", "autoscaling.targetMemoryUtilizationPercentage=70"),
            expectedResources: map[string]int{"cpu": 60, "memory": 70},
        },
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            manifest := suite.Chart.Manifests.Get("HorizontalPodAutoscaler", "common-test")
            suite.Assertions.NotEmpty(manifest)

            manifestMetrics := manifest.Path("spec.metrics").Children()

            metricsMap := make(map[string]int)
            for _, manifestMetric := range manifestMetrics {
                metricsMap[manifestMetric.Path("resource.name").Data().(string)] = int(manifestMetric.Path("resource.targetAverageUtilization").Data().(float64))
            }

            suite.Assertions.EqualValues(tc.expectedResources, metricsMap)
        })
    }
}
