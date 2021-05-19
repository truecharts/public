package common

import (
    "testing"

    "github.com/truecharts/apps/test/helmunit"
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
