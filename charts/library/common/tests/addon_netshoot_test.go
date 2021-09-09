package common

import (
    "testing"

    "github.com/Jeffail/gabs/v2"
    "github.com/truecharts/apps/tests/helmunit"
    "github.com/stretchr/testify/suite"
)

type AddonNetshootTestSuite struct {
    suite.Suite
    Chart      helmunit.HelmChart
    baseValues []string
}

func (suite *AddonNetshootTestSuite) SetupSuite() {
    suite.Chart = helmunit.New("common-test", "../../common-test")
    suite.Chart.UpdateDependencies()
    suite.baseValues = []string{"addons.netshoot.enabled=true"}
}

// We need this function to kick off the test suite, otherwise
// "go test" won't know about our tests
func TestAddonNetshoot(t *testing.T) {
    suite.Run(t, new(AddonNetshootTestSuite))
}

func (suite *AddonNetshootTestSuite) TestContainer() {
    tests := map[string]struct {
        values                    []string
        expectedNetshootContainer bool
    }{
        "Default":      {values: nil, expectedNetshootContainer: false},
        "AddonEnabled": {values: suite.baseValues, expectedNetshootContainer: true},
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

            var netshootContainer *gabs.Container
            for _, container := range containers {
                containerName := container.Path("name").Data().(string)
                if containerName == "netshoot" {
                    netshootContainer = container
                    break
                }
            }

            if tc.expectedNetshootContainer {
                suite.Assertions.NotEmpty(netshootContainer)
            } else {
                suite.Assertions.Empty(netshootContainer)
            }
        })
    }
}
