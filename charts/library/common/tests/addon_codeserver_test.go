package common

import (
    "testing"

    "github.com/Jeffail/gabs/v2"
    "github.com/truecharts/apps/tests/helmunit"
    "github.com/stretchr/testify/suite"
)

type AddonCodeserverTestSuite struct {
    suite.Suite
    Chart      helmunit.HelmChart
    baseValues string
}

func (suite *AddonCodeserverTestSuite) SetupSuite() {
    suite.Chart = helmunit.New("common-test", "../../common-test")
    suite.Chart.UpdateDependencies()
    suite.baseValues = `
        addons:
            codeserver:
                enabled: true
                volumeMounts:
                  - name: "config"
                    mountPath: "/data/config"
    `
}

// We need this function to kick off the test suite, otherwise
// "go test" won't know about our tests
func TestAddonCodeserver(t *testing.T) {
    suite.Run(t, new(AddonCodeserverTestSuite))
}

func (suite *AddonCodeserverTestSuite) TestContainer() {
    tests := map[string]struct {
        values                      *string
        expectedCodeserverContainer bool
    }{
        "Default":      {values: nil, expectedCodeserverContainer: false},
        "AddonEnabled": {values: &suite.baseValues, expectedCodeserverContainer: true},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, nil, tc.values)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            suite.Assertions.NotEmpty(deploymentManifest)
            containers := deploymentManifest.Path("spec.template.spec.containers").Children()

            var codeserverContainer *gabs.Container
            for _, container := range containers {
                containerName := container.Path("name").Data().(string)
                if containerName == "codeserver" {
                    codeserverContainer = container
                    break
                }
            }

            if tc.expectedCodeserverContainer {
                suite.Assertions.NotEmpty(codeserverContainer)
            } else {
                suite.Assertions.Empty(codeserverContainer)
            }
        })
    }
}

func (suite *AddonCodeserverTestSuite) TestDeployKey() {
    tests := map[string]struct {
        values             []string
        expectSecret       bool
        expectedSecretName string
    }{
        "Inline":         {values: []string{"addons.codeserver.git.deployKey=test"}, expectSecret: true, expectedSecretName: "common-test-deploykey"},
        "InlineBase64":   {values: []string{"addons.codeserver.git.deployKeyBase64=dGVzdEtleQ=="}, expectSecret: true, expectedSecretName: "common-test-deploykey"},
        "ExistingSecret": {values: []string{"addons.codeserver.git.deployKeySecret=test-secret"}, expectSecret: false, expectedSecretName: "test-secret"},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, &suite.baseValues)
            if err != nil {
                suite.FailNow(err.Error())
            }

            secretManifest := suite.Chart.Manifests.Get("Secret", tc.expectedSecretName)
            if tc.expectSecret {
                suite.Assertions.NotEmpty(secretManifest)
            } else {
                suite.Assertions.Empty(secretManifest)
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            suite.Assertions.NotEmpty(deploymentManifest)

            containers := deploymentManifest.Path("spec.template.spec.containers").Children()
            var codeserverContainer *gabs.Container
            for _, container := range containers {
                containerName := container.Path("name").Data().(string)
                if containerName == "codeserver" {
                    codeserverContainer = container
                    break
                }
            }
            suite.Assertions.NotEmpty(codeserverContainer)

            volumeMounts := codeserverContainer.Path("volumeMounts").Children()
            var gitDeploykeyVolumeMount *gabs.Container
            for _, volumeMount := range volumeMounts {
                volumeMountName := volumeMount.Path("name").Data().(string)
                if volumeMountName == "deploykey" {
                    gitDeploykeyVolumeMount = volumeMount
                    break
                }
            }
            suite.Assertions.NotEmpty(gitDeploykeyVolumeMount)
            suite.Assertions.EqualValues("/root/.ssh/id_rsa", gitDeploykeyVolumeMount.Path("mountPath").Data())
            suite.Assertions.EqualValues("id_rsa", gitDeploykeyVolumeMount.Path("subPath").Data())

            volumes := deploymentManifest.Path("spec.template.spec.volumes").Children()
            var gitDeploykeyVolume *gabs.Container
            for _, volume := range volumes {
                volumeName := volume.Path("name").Data().(string)
                if volumeName == "deploykey" {
                    gitDeploykeyVolume = volume
                    break
                }
            }
            suite.Assertions.NotEmpty(gitDeploykeyVolume)
        })
    }
}
