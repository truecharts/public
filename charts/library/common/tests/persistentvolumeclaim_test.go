package common

import (
    "testing"

    "github.com/truecharts/apps/tests/helmunit"
    "github.com/stretchr/testify/suite"
)

type PersistenceVolumeClaimTestSuite struct {
    suite.Suite
    Chart helmunit.HelmChart
}

func (suite *PersistenceVolumeClaimTestSuite) SetupSuite() {
    suite.Chart = helmunit.New("common-test", "../../common-test")
    suite.Chart.UpdateDependencies()
}

// We need this function to kick off the test suite, otherwise
// "go test" won't know about our tests
func TestPersistenceVolumeClaim(t *testing.T) {
    suite.Run(t, new(PersistenceVolumeClaimTestSuite))
}

func (suite *PersistenceVolumeClaimTestSuite) TestName() {
    tests := map[string]struct {
        values       []string
        expectedName string
    }{
        "Default":          {values: []string{"persistence.config.enabled=true"}, expectedName: "common-test-config"},
        "WithoutSuffix":    {values: []string{"persistence.config.enabled=true", "persistence.config.nameOverride=-"}, expectedName: "common-test"},
        "WithNameOverride": {values: []string{"persistence.config.enabled=true", "persistence.config.nameOverride=custom"}, expectedName: "common-test-custom"},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            pvcManifest := suite.Chart.Manifests.Get("PersistentVolumeClaim", tc.expectedName)
            suite.Assertions.NotEmpty(pvcManifest)
        })
    }
}

func (suite *PersistenceVolumeClaimTestSuite) TestStorageClass() {
    tests := map[string]struct {
        values               []string
        expectedStorageClass string
    }{
        "Default":     {values: []string{"persistence.config.enabled=true"}, expectedStorageClass: "-"},
        "CustomClass": {values: []string{"persistence.config.enabled=true", "persistence.config.storageClass=custom"}, expectedStorageClass: "custom"},
        "ScaleZFS":    {values: []string{"persistence.config.enabled=true", "persistence.config.storageClass=SCALE-ZFS"}, expectedStorageClass: "ix-storage-class-common-test"},
        "Empty":       {values: []string{"persistence.config.enabled=true", "persistence.config.storageClass=-"}, expectedStorageClass: ""},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            pvcManifest := suite.Chart.Manifests.Get("PersistentVolumeClaim", "common-test-config")
            suite.Assertions.NotEmpty(pvcManifest)

            if tc.expectedStorageClass == "-" {
                suite.Assertions.Empty(pvcManifest.Path("spec.storageClassName").Data())
            } else {
                suite.Assertions.EqualValues(tc.expectedStorageClass, pvcManifest.Path("spec.storageClassName").Data())
            }
        })
    }
}

func (suite *PersistenceVolumeClaimTestSuite) TestMetaData() {
    defaultChartAnnotations := make(map[string]interface{})
    defaultChartLabels := map[string]interface{}{
        "app.kubernetes.io/instance":   "common-test",
        "app.kubernetes.io/managed-by": "Helm",
        "app.kubernetes.io/name":       "common-test",
        "app.kubernetes.io/version":"latest",
        "helm.sh/chart":                "common-test-3.1.2",
    }

    tests := map[string]struct {
        values              []string
        expectedAnnotations map[string]interface{}
        expectedLabels      map[string]interface{}
    }{
        "Default": {
            values: []string{
                "persistence.config.enabled=true",
            },
            expectedAnnotations: nil,
            expectedLabels:      nil,
        },
        "NoRetain": {
            values: []string{
                "persistence.config.enabled=true",
                "persistence.config.labels.test_label=test",
                "persistence.config.annotations.test_annotation=test",
            },
            expectedAnnotations: map[string]interface{}{
                "test_annotation": "test",
            },
            expectedLabels: map[string]interface{}{
                "test_label": "test",
            },
        },
        "Retain": {
            values: []string{
                "persistence.config.enabled=true",
                "persistence.config.retain=true",
                "persistence.config.labels.test_label=test",
                "persistence.config.annotations.test_annotation=test",
            },
            expectedAnnotations: map[string]interface{}{
                "helm.sh/resource-policy": "keep",
                "test_annotation":         "test",
            },
            expectedLabels: map[string]interface{}{
                "test_label": "test",
            },
        },
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            pvcManifest := suite.Chart.Manifests.Get("PersistentVolumeClaim", "common-test-config")
            suite.Assertions.NotEmpty(pvcManifest)

            pvcAnnotations := pvcManifest.Path("metadata.annotations").Data()
            testAnnotations := make(map[string]interface{})
            for index, element := range defaultChartAnnotations {
                testAnnotations[index] = element
            }
            for index, element := range tc.expectedAnnotations {
                testAnnotations[index] = element
            }

            if len(testAnnotations) == 0 {
                suite.Assertions.Equal(nil, pvcAnnotations)
            } else {
                suite.Assertions.EqualValues(testAnnotations, pvcAnnotations)
            }

            pvcLabels := pvcManifest.Path("metadata.labels").Data()
            testLabels := make(map[string]interface{})
            for index, element := range defaultChartLabels {
                testLabels[index] = element
            }
            for index, element := range tc.expectedLabels {
                testLabels[index] = element
            }
            if len(testLabels) == 0 {
                suite.Assertions.Equal(nil, pvcLabels)
            } else {
                suite.Assertions.EqualValues(testLabels, pvcLabels)
            }
        })
    }
}
