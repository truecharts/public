package common

import (
    "testing"

    "github.com/truecharts/apps/tests/helmunit"
    "github.com/stretchr/testify/suite"
)

type PodTestSuite struct {
    suite.Suite
    Chart helmunit.HelmChart
}

func (suite *PodTestSuite) SetupSuite() {
    suite.Chart = helmunit.New("common-test", "../../common-test")
    suite.Chart.UpdateDependencies()
}

// We need this function to kick off the test suite, otherwise
// "go test" won't know about our tests
func TestPod(t *testing.T) {
    suite.Run(t, new(PodTestSuite))
}

func (suite *PodTestSuite) TestReplicas() {
    tests := map[string]struct {
        values        []string
        expectedValue interface{}
    }{
        "Default":   {values: nil, expectedValue: 1},
        "Specified": {values: []string{"controller.replicas=3"}, expectedValue: 3},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            suite.Assertions.NotEmpty(deploymentManifest)
            suite.Assertions.EqualValues(tc.expectedValue, deploymentManifest.Path("spec.replicas").Data())
        })
    }
}

func (suite *PodTestSuite) TestHostNetwork() {
    tests := map[string]struct {
        values        []string
        expectedValue interface{}
    }{
        "Default":        {values: nil, expectedValue: nil},
        "SpecifiedTrue":  {values: []string{"hostNetwork=true"}, expectedValue: true},
        "SpecifiedFalse": {values: []string{"hostNetwork=false"}, expectedValue: nil},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            suite.Assertions.NotEmpty(deploymentManifest)
            suite.Assertions.EqualValues(tc.expectedValue, deploymentManifest.Path("spec.template.spec.hostNetwork").Data())
        })
    }
}

func (suite *PodTestSuite) TestDnsPolicy() {
    tests := map[string]struct {
        values        []string
        expectedValue interface{}
    }{
        "Default":          {values: nil, expectedValue: "ClusterFirst"},
        "HostnetworkFalse": {values: []string{"hostNetwork=false"}, expectedValue: "ClusterFirst"},
        "HostnetworkTrue":  {values: []string{"hostNetwork=true"}, expectedValue: "ClusterFirstWithHostNet"},
        "ManualOverride":   {values: []string{"dnsPolicy=None"}, expectedValue: "None"},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            suite.Assertions.NotEmpty(deploymentManifest)
            suite.Assertions.EqualValues(tc.expectedValue, deploymentManifest.Path("spec.template.spec.dnsPolicy").Data())
        })
    }
}

func (suite *PodTestSuite) TestAdditionalContainers() {
    tests := map[string]struct {
        values            []string
        expectedContainer interface{}
    }{
        "Static":          {values: []string{"additionalContainers[0].name=template-test"}, expectedContainer: "template-test"},
        "DynamicTemplate": {values: []string{`additionalContainers[0].name=\{\{ .Release.Name \}\}-container`}, expectedContainer: "common-test-container"},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            containers := deploymentManifest.Path("spec.template.spec.containers")
            suite.Assertions.Contains(containers.Search("*", "name").Data(), tc.expectedContainer)
        })
    }
}
func (suite *PodTestSuite) TestPersistenceItems() {
    values := `
        persistence:
            cache:
                enabled: true
                type: emptyDir
            config:
                enabled: true
            data:
                enabled: true
                existingClaim: dataClaim
            custom-mount:
                enabled: true
                type: custom
                volumeSpec:
                    downwardAPI:
                        items:
                            - path: "labels"
                              fieldRef:
                                  fieldPath: metadata.labels
    `
    tests := map[string]struct {
        values          *string
        expectedVolumes []string
    }{
        "Default":       {values: nil, expectedVolumes: []string{"shared"}},
        "MultipleItems": {values: &values, expectedVolumes: []string{"config", "cache", "data", "custom-mount"}},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, nil, tc.values)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            volumes := deploymentManifest.Path("spec.template.spec.volumes")

            if tc.expectedVolumes == nil {
                suite.Assertions.EqualValues(nil, volumes.Data())
            } else {
                suite.Assertions.NotEmpty(volumes)
                searchVolumes := volumes.Search("*", "name").Data()
                for _, expectedVolume := range tc.expectedVolumes {
                    suite.Assertions.Contains(searchVolumes, expectedVolume)
                }
            }
        })
    }
}

func (suite *PodTestSuite) TestPersistenceClaimNames() {
    values := `
        persistence:
            config:
                enabled: true
            existingClaim:
                enabled: true
                existingClaim: myClaim
            claimWithoutSuffix:
                enabled: true
                nameOverride: "-"
                accessMode: ReadWriteMany
                size: 1G
            claimWithNameOverride:
                enabled: true
                nameOverride: suffix
                accessMode: ReadWriteMany
                size: 1G
    `
    tests := map[string]struct {
        values            *string
        volumeToTest      string
        expectedClaimName string
    }{
        "DefaultClaimName":          {values: &values, volumeToTest: "config", expectedClaimName: "common-test-config"},
        "ClaimNameWithoutSuffix":    {values: &values, volumeToTest: "claimWithoutSuffix", expectedClaimName: "common-test"},
        "ClaimNameWithNameOverride": {values: &values, volumeToTest: "claimWithNameOverride", expectedClaimName: "common-test-suffix"},
        "ExistingClaim":             {values: &values, volumeToTest: "existingClaim", expectedClaimName: "myClaim"},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, nil, tc.values)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            volumes := deploymentManifest.Path("spec.template.spec.volumes").Children()

            for _, volume := range volumes {
                volumeName := volume.Path("name").Data().(string)
                if volumeName == tc.volumeToTest {
                    suite.Assertions.EqualValues(tc.expectedClaimName, volume.Path("persistentVolumeClaim.claimName").Data())
                    break
                }
            }
        })
    }
}

func (suite *PodTestSuite) TestPersistenceEmptyDir() {
    baseValues := `
        persistence:
            config:
                enabled: true
                type: emptyDir
    `
    tests := map[string]struct {
        values            []string
        expectedMedium    string
        expectedSizeLimit string
    }{
        "Enabled":       {values: nil, expectedMedium: "", expectedSizeLimit: ""},
        "WithMedium":    {values: []string{"persistence.config.medium=memory"}, expectedMedium: "memory", expectedSizeLimit: ""},
        "WithSizeLimit": {values: []string{"persistence.config.medium=memory", "persistence.config.sizeLimit=1Gi"}, expectedMedium: "memory", expectedSizeLimit: "1Gi"},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, &baseValues)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            volumes := deploymentManifest.Path("spec.template.spec.volumes").Children()
            volume := volumes[0]
            suite.Assertions.NotEmpty(volume.Data())

            if tc.expectedMedium == "" {
                suite.Assertions.Nil(volume.Path("emptyDir.medium"))
            } else {
                suite.Assertions.EqualValues(tc.expectedMedium, volume.Path("emptyDir.medium").Data())
            }

            if tc.expectedSizeLimit == "" {
                suite.Assertions.Nil(volume.Path("emptyDir.sizeLimit"))
            } else {
                suite.Assertions.EqualValues(tc.expectedSizeLimit, volume.Path("emptyDir.sizeLimit").Data())
            }

        })
    }
}

func (suite *PodTestSuite) TestHostPathVolumes() {
    values := `
        persistence:
            hostpathmounts-data:
                enabled: true
                type: hostPath
                hostPath: "/tmp1"
                mountPath: "/data"
            hostpathmounts-with-type:
                enabled: true
                type: hostPath
                hostPath: "/tmp2"
                hostPathType: "Directory"
                mountPath: "/data2"
    `
    tests := map[string]struct {
        values          *string
        expectedVolumes []string
    }{
        "Default":       {values: nil, expectedVolumes: []string{"shared"}},
        "MultipleItems": {values: &values, expectedVolumes: []string{"hostpathmounts-data", "hostpathmounts-with-type"}},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, nil, tc.values)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            volumes := deploymentManifest.Path("spec.template.spec.volumes")

            if tc.expectedVolumes == nil {
                suite.Assertions.EqualValues(nil, volumes.Data())
            } else {
                suite.Assertions.NotEmpty(volumes)
                searchVolumes := volumes.Search("*", "name").Data()
                for _, expectedVolume := range tc.expectedVolumes {
                    suite.Assertions.Contains(searchVolumes, expectedVolume)
                }
            }
        })
    }
}

func (suite *PodTestSuite) TestVolumeClaimTemplates() {
    values := `
        volumeClaimTemplates:
          - name: 'storage'
            accessMode: 'ReadWriteOnce'
            size: '10Gi'
            storageClass: 'storage'
    `
    tests := map[string]struct {
        values                   []string
        volumeClaimToTest        string
        expectedAccessMode       string
        expectedSize             string
        expectedStorageClassName string
    }{
        "StatefulSet": {values: []string{"controller.type=statefulset"}, volumeClaimToTest: "storage", expectedAccessMode: "ReadWriteOnce", expectedSize: "10Gi", expectedStorageClassName: "storage"},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, &values)
            if err != nil {
                suite.FailNow(err.Error())
            }

            controllerManifest := suite.Chart.Manifests.Get("StatefulSet", "common-test")
            suite.Assertions.NotEmpty(controllerManifest)

            volumeClaimTemplates := controllerManifest.Path("spec.volumeClaimTemplates").Children()
            suite.Assertions.NotEmpty(volumeClaimTemplates)

            for _, volumeClaimTemplate := range volumeClaimTemplates {
                volumeClaimName := volumeClaimTemplate.Path("metadata.name").Data()
                if volumeClaimName == tc.volumeClaimToTest {
                    if tc.expectedAccessMode == "" {
                        suite.Assertions.Empty(controllerManifest)
                    } else {
                        accessModes := volumeClaimTemplate.Path("spec.accessModes").Children()
                        suite.Assertions.EqualValues(tc.expectedAccessMode, accessModes[0].Data())
                    }

                    if tc.expectedSize == "" {
                        suite.Assertions.Empty(controllerManifest)
                    } else {
                        suite.Assertions.EqualValues(tc.expectedSize, volumeClaimTemplate.Path("spec.resources.requests.storage").Data())
                    }

                    if tc.expectedStorageClassName == "" {
                        suite.Assertions.Empty(controllerManifest)
                    } else {
                        suite.Assertions.EqualValues(tc.expectedStorageClassName, volumeClaimTemplate.Path("spec.storageClassName").Data())
                    }
                    break
                }
            }
        })
    }
}
