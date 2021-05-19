package common

import (
    "testing"

    "github.com/truecharts/apps/test/helmunit"
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
                "hostPathMounts[0].name=data",
                "hostPathMounts[0].enabled=true",
                "hostPathMounts[0].mountPath=/data",
                "hostPathMounts[0].hostPath=/tmp",
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
        "Default": {
            values: []string{
                "hostPathMounts[0].name=data",
                "hostPathMounts[0].enabled=true",
                "hostPathMounts[0].mountPath=/data",
                "hostPathMounts[0].hostPath=/tmp",
            },
            expectedVolumes: nil,
        },
        "MultipleHostPathMounts": {
            values: []string{
                "hostPathMounts[0].name=data",
                "hostPathMounts[0].enabled=true",
                "hostPathMounts[0].setPermissions=true",
                "hostPathMounts[0].mountPath=/data",
                "hostPathMounts[0].hostPath=/tmp",
                "hostPathMounts[1].name=config",
                "hostPathMounts[1].enabled=true",
                "hostPathMounts[1].setPermissions=true",
                "hostPathMounts[1].mountPath=/config",
                "hostPathMounts[1].hostPath=/tmp",
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
        "hostPathMounts[0].name=data",
        "hostPathMounts[0].enabled=true",
        "hostPathMounts[0].setPermissions=true",
        "hostPathMounts[0].mountPath=/data",
        "hostPathMounts[0].hostPath=/tmp",
        "hostPathMounts[1].name=config",
        "hostPathMounts[1].enabled=true",
        "hostPathMounts[1].setPermissions=true",
        "hostPathMounts[1].mountPath=/config",
        "hostPathMounts[1].hostPath=/tmp",
    }
    tests := map[string]struct {
        values          []string
        expectedCommand []string
    }{
        "DefaultPermissionsForMultipleMounts": {
            values: baseValues,
            expectedCommand: []string{
                "/bin/sh", "-c", "chown -R 568:568 /config\nchown -R 568:568 /data\n",
            },
        },
        "DefaultPermissionsForDisabledpodSecurityContext": {
            values: append(baseValues,
                "podSecurityContext.allowPrivilegeEscalation=false",
            ),
            expectedCommand: []string{
                "/bin/sh", "-c", "chown -R 568:568 /config\nchown -R 568:568 /data\n",
            },
        },
        "PermissionsForFsGroup": {
            values: append(baseValues,
                "podSecurityContext.fsGroup=666",
            ),
            expectedCommand: []string{
                "/bin/sh", "-c", "chown -R 568:666 /config\nchown -R 568:666 /data\n",
            },
        },
        "PermissionsForRunAsUser": {
            values: append(baseValues,
                "podSecurityContext.runAsUser=999",
            ),
            expectedCommand: []string{
                "/bin/sh", "-c", "chown -R 999:568 /config\nchown -R 999:568 /data\n",
            },
        },
        "PermissionsForRunAsUserAndFsGroup": {
            values: append(baseValues,
                "podSecurityContext.runAsUser=999",
                "podSecurityContext.fsGroup=666",
            ),
            expectedCommand: []string{
                "/bin/sh", "-c", "chown -R 999:666 /config\nchown -R 999:666 /data\n",
            },
        },
        "PermissionsForPgidPuid": {
            values: append(baseValues,
                "env.PUID=999",
                "env.PGID=666",
            ),
            expectedCommand: []string{
                "/bin/sh", "-c", "chown -R 999:666 /config\nchown -R 999:666 /data\n",
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
            if tc.expectedCommand != nil {
                actualCommand := []string{}

                for _, v := range command {
                    actualCommand = append(actualCommand, v.Data().(string))
                }

                suite.Assertions.EqualValues(tc.expectedCommand, actualCommand)
            } else {
                suite.Assertions.Empty(command)
            }
        })
    }
}
