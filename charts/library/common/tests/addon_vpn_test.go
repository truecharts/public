package common

import (
    "testing"

    "github.com/Jeffail/gabs/v2"
    "github.com/truecharts/apps/tests/helmunit"
    "github.com/stretchr/testify/suite"
)

type AddonVpnTestSuite struct {
    suite.Suite
    Chart      helmunit.HelmChart
    baseValues []string
}

func (suite *AddonVpnTestSuite) SetupSuite() {
    suite.Chart = helmunit.New("common-test", "../../common-test")
    suite.Chart.UpdateDependencies()
    suite.baseValues = []string{"addons.vpn.enabled=true"}
}

// We need this function to kick off the test suite, otherwise
// "go test" won't know about our tests
func TestAddonVpn(t *testing.T) {
    suite.Run(t, new(AddonVpnTestSuite))
}

func (suite *AddonVpnTestSuite) TestContainer() {
    tests := map[string]struct {
        values               []string
        expectedVpnContainer bool
    }{
        "Default":      {values: nil, expectedVpnContainer: false},
        "AddonEnabled": {values: suite.baseValues, expectedVpnContainer: true},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            deploymentManifest := suite.Chart.Manifests.Get("Deployment", "common-test")
            suite.Assertions.NotEmpty(deploymentManifest)
            containers := deploymentManifest.Path("spec.template.spec.containers").Children()

            var vpnContainer *gabs.Container
            for _, container := range containers {
                containerName := container.Path("name").Data().(string)
                if containerName == "openvpn" {
                    vpnContainer = container
                    break
                }
            }

            if tc.expectedVpnContainer {
                suite.Assertions.NotEmpty(vpnContainer)
            } else {
                suite.Assertions.Empty(vpnContainer)
            }
        })
    }
}

func (suite *AddonVpnTestSuite) TestConfiguration() {
    tests := map[string]struct {
        values             []string
        expectSecret       bool
        expectedSecretName string
    }{
        "InlineConfig":   {values: append(suite.baseValues, "addons.vpn.configFile=test"), expectSecret: true, expectedSecretName: "common-test-vpnconfig"},
        "ExistingSecret": {values: append(suite.baseValues, "addons.vpn.configFileSecret=test-secret"), expectSecret: false, expectedSecretName: "test-secret"},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
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
            var vpnContainer *gabs.Container
            for _, container := range containers {
                containerName := container.Path("name").Data().(string)
                if containerName == "openvpn" {
                    vpnContainer = container
                    break
                }
            }
            suite.Assertions.NotEmpty(vpnContainer)

            volumeMounts := vpnContainer.Path("volumeMounts").Children()
            var vpnConfigVolumeMount *gabs.Container
            for _, volumeMount := range volumeMounts {
                volumeMountName := volumeMount.Path("name").Data().(string)
                if volumeMountName == "vpnconfig" {
                    vpnConfigVolumeMount = volumeMount
                    break
                }
            }
            suite.Assertions.NotEmpty(vpnConfigVolumeMount)
            suite.Assertions.EqualValues("/vpn/vpn.conf", vpnConfigVolumeMount.Path("mountPath").Data())
            suite.Assertions.EqualValues("vpnConfigfile", vpnConfigVolumeMount.Path("subPath").Data())

            volumes := deploymentManifest.Path("spec.template.spec.volumes").Children()
            var vpnConfigVolume *gabs.Container
            for _, volume := range volumes {
                volumeName := volume.Path("name").Data().(string)
                if volumeName == "vpnconfig" {
                    vpnConfigVolume = volume
                    break
                }
            }
            suite.Assertions.NotEmpty(vpnConfigVolume)

        })
    }
}
