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
    suite.baseValues = []string{"addons.vpn.type=openvpn"}
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
