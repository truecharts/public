package common

import (
    "testing"

    "github.com/truecharts/apps/tests/helmunit"
    "github.com/stretchr/testify/suite"
)

type PermissionsJobTestSuite struct {
    suite.Suite
    Chart helmunit.HelmChart
}

func (suite *PermissionsJobTestSuite) SetupSuite() {
    suite.Chart = helmunit.New("common-test", "../../common-test")
    suite.Chart.UpdateDependencies()
}

// We need this function to kick off the test suite, otherwise
// "go test" won't know about our tests
func TestPermissionsJob(t *testing.T) {
    suite.Run(t, new(PermissionsJobTestSuite))
}

func (suite *PermissionsJobTestSuite) TestPresence() {
    tests := map[string]struct {
        values      []string
        expectedJob bool
    }{
        "Default": {
            values:      nil,
            expectedJob: false,
        },
        "WithHostPathMount": {
            values: []string{
                "persistenceList[0].name=data",
                "persistenceList[0].type=hostPath",
                "persistenceList[0].enabled=true",
                "persistenceList[0].mountPath=/data",
                "persistenceList[0].setPermissions=true",
                "persistenceList[0].hostPath=/tmp",
            },
            expectedJob: true,
        },
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            jobManifest := suite.Chart.Hooks.Get("Job", "common-test-auto-permissions")
            if tc.expectedJob {
                suite.Assertions.NotEmpty(jobManifest)
            } else {
                suite.Assertions.Empty(jobManifest)
            }
        })
    }
}

func (suite *PermissionsJobTestSuite) TestVolumesAndMounts() {
    tests := map[string]struct {
        values          []string
        expectedVolumes []string
    }{
        "MultiplepersistenceList": {
            values: []string{
                "persistenceList[0].name=data",
                "persistenceList[0].type=hostPath",
                "persistenceList[0].enabled=true",
                "persistenceList[0].setPermissions=true",
                "persistenceList[0].mountPath=/data",
                "persistenceList[0].hostPath=/tmp",
                "persistenceList[1].name=config",
                "persistenceList[1].type=hostPath",
                "persistenceList[1].enabled=true",
                "persistenceList[1].setPermissions=true",
                "persistenceList[1].mountPath=/config",
                "persistenceList[1].hostPath=/tmp",
            },
            expectedVolumes: []string{"hostpathmounts-config", "hostpathmounts-data"},
        },
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            jobManifest := suite.Chart.Hooks.Get("Job", "common-test-auto-permissions")
            suite.Assertions.NotEmpty(jobManifest)

            jobVolumes, _ := jobManifest.Path("spec.template.spec.volumes").Search("name").Children()
            containers, _ := jobManifest.Path("spec.template.spec.containers").Children()
            jobVolumeMounts, _ := containers[0].Path("volumeMounts").Search("name").Children()
            if tc.expectedVolumes != nil {
                actualVolumes := []string{}
                actualVolumeMounts := []string{}

                for _, v := range jobVolumes {
                    actualVolumes = append(actualVolumes, v.Data().(string))
                }
                for _, v := range jobVolumeMounts {
                    actualVolumeMounts = append(actualVolumeMounts, v.Data().(string))
                }

                suite.Assertions.EqualValues(tc.expectedVolumes, actualVolumeMounts)
                suite.Assertions.EqualValues(tc.expectedVolumes, actualVolumes)
            } else {
                suite.Assertions.Empty(jobVolumes)
            }
        })
    }
}

func (suite *PermissionsJobTestSuite) TestCommand() {
    baseValues := []string{
        "persistenceList[0].name=data",
        "persistenceList[0].type=hostPath",
        "persistenceList[0].enabled=true",
        "persistenceList[0].setPermissions=true",
        "persistenceList[0].mountPath=/data",
        "persistenceList[0].hostPath=/tmp",
        "persistenceList[1].name=config",
        "persistenceList[1].type=hostPath",
        "persistenceList[1].enabled=true",
        "persistenceList[1].setPermissions=true",
        "persistenceList[1].mountPath=/config",
        "persistenceList[1].hostPath=/tmp",
    }
    tests := map[string]struct {
        values          []string
        expectedCommand []string
        expectedArgs []string
    }{
        "DefaultPermissionsForMultipleMounts": {
            values: baseValues,
            expectedCommand: []string{
                "/bin/sh", "-c",
            },
            expectedArgs: []string{
                "chown -R :568 '/config'", "chown -R :568 '/data'",
            },
        },
        "DefaultPermissionsForDisabledpodSecurityContext": {
            values: append(baseValues,
                "podSecurityContext.allowPrivilegeEscalation=false",
            ),
            expectedCommand: []string{
                "/bin/sh", "-c",
            },
            expectedArgs: []string{
                "chown -R :568 '/config'", "chown -R :568 '/data'",
            },
        },
        "PermissionsForFsGroup": {
            values: append(baseValues,
                "podSecurityContext.fsGroup=666",
            ),
            expectedCommand: []string{
                "/bin/sh", "-c",
            },
            expectedArgs: []string{
                "chown -R :666 '/config'", "chown -R :666 '/data'",
            },
        },
        "PermissionsForPgid": {
            values: append(baseValues,
                "env.PGID=666",
            ),
            expectedCommand: []string{
                "/bin/sh", "-c",
            },
            expectedArgs: []string{
                "chown -R :666 '/config'", "chown -R :666 '/data'",
            },
        },
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            jobManifest := suite.Chart.Hooks.Get("Job", "common-test-auto-permissions")
            suite.Assertions.NotEmpty(jobManifest)

            containers, _ := jobManifest.Path("spec.template.spec.containers").Children()
            command, _ := containers[0].Path("command").Children()
            args, _ := containers[0].Path("args").Children()
            if tc.expectedCommand != nil {
                actualCommand := []string{}

                for _, v := range command {
                    actualCommand = append(actualCommand, v.Data().(string))
                }

                suite.Assertions.EqualValues(tc.expectedCommand, actualCommand)
            } else {
                suite.Assertions.Empty(command)
            }
            if tc.expectedArgs != nil {
                actualArgs := []string{}

                for _, v := range args {
                    actualArgs = append(actualArgs, v.Data().(string))
                }

                suite.Assertions.EqualValues(tc.expectedArgs, actualArgs)
            } else {
                suite.Assertions.Empty(args)
            }
        })
    }
}
