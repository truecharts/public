package common

import (
    "testing"

    "github.com/truecharts/apps/test/helmunit"
    "github.com/stretchr/testify/suite"
)

type ControllerTestSuite struct {
    suite.Suite
    Chart helmunit.HelmChart
}

func (suite *ControllerTestSuite) SetupSuite() {
    suite.Chart = helmunit.New("common-test", "../../common-test")
    suite.Chart.UpdateDependencies()
}

// We need this function to kick off the test suite, otherwise
// "go test" won't know about our tests
func TestController(t *testing.T) {
    suite.Run(t, new(ControllerTestSuite))
}

func (suite *ControllerTestSuite) TestTypes() {
    tests := map[string]struct {
        values                []string
        expectedRenderFailure bool
        expectedController    string
    }{
        "Default":     {values: nil, expectedRenderFailure: false, expectedController: "deployment"},
        "DaemonSet":   {values: []string{"controller.type=daemonset"}, expectedRenderFailure: false, expectedController: "daemonset"},
        "Deployment":  {values: []string{"controller.type=deployment"}, expectedRenderFailure: false, expectedController: "deployment"},
        "StatefulSet": {values: []string{"controller.type=statefulset"}, expectedRenderFailure: false, expectedController: "statefulset"},
        "Custom":      {values: []string{"controller.type=custom"}, expectedRenderFailure: true, expectedController: ""},
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if tc.expectedRenderFailure {
                suite.Assertions.Error(err)
                return
            }
            if err != nil {
                suite.FailNow(err.Error())
            }

            manifest := suite.Chart.Manifests.Get(tc.expectedController, "common-test")
            suite.Assertions.NotEmpty(manifest)

            types := map[string]interface{}{"deployment": nil, "statefulset": nil, "daemonset": nil}
            delete(types, tc.expectedController)
            for k := range types {
                suite.Assertions.Empty(suite.Chart.Manifests.Get(k, "common-test"))
            }
        })
    }
}
