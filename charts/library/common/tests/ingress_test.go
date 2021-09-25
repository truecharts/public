package common

import (
    "testing"

    "github.com/truecharts/apps/tests/helmunit"
    "github.com/stretchr/testify/suite"
)

type IngressTestSuite struct {
    suite.Suite
    Chart helmunit.HelmChart
}

func (suite *IngressTestSuite) SetupSuite() {
    suite.Chart = helmunit.New("common-test", "../../common-test")
    suite.Chart.UpdateDependencies()
}

// We need this function to kick off the test suite, otherwise
// "go test" won't know about our tests
func TestIngress(t *testing.T) {
    suite.Run(t, new(IngressTestSuite))
}

func (suite *IngressTestSuite) TestValues() {
    tests := map[string]struct {
        values           []string
        expectedIngress  bool
        expectedHostName string
        expectedPath     string
    }{
        "Default": {
            values:          nil,
            expectedIngress: false,
        },
        "Disabled": {
            values:          []string{"ingress.main.enabled=false"},
            expectedIngress: false,
        },
        "CustomHostAndPath": {
            values: []string{
                "ingress.main.enabled=true",
                "ingress.main.hosts[0].host=chart-test.local",
                "ingress.main.hosts[0].paths[0].path=/test",
            },
            expectedIngress:  true,
            expectedHostName: "chart-test.local",
            expectedPath:     "/test",
        },
        "Multiple": {
            values: []string{
                "ingress.main.enabled=true",
                "ingress.secondary.enabled=true",
            },
            expectedIngress: true,
        },
        "PathTemplate": {
            values: []string{
                "ingress.main.enabled=true",
                "ingress.main.hosts[0].host=chart-example.local",
                `ingress.main.hosts[0].paths[0].path=\{\{ .Release.Name \}\}.path`,
            },
            expectedIngress: true,
            expectedPath:    "common-test.path",
        },
        "HostTemplate": {
            values: []string{
                "ingress.main.enabled=true",
                `ingress.main.hosts[0].host=\{\{ .Release.Name \}\}.hostname`,
                "ingress.main.hosts[0].paths[0].path=/",
            },
            expectedIngress:  true,
            expectedHostName: "common-test.hostname",
        },
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            ingressManifest := suite.Chart.Manifests.Get("Ingress", "common-test")
            if tc.expectedIngress {
                suite.Assertions.NotEmpty(ingressManifest)

                ingressRules := ingressManifest.Path("spec.rules").Children()
                if tc.expectedHostName != "" {
                    suite.Assertions.EqualValues(tc.expectedHostName, ingressRules[0].Path("host").Data())
                }

                if tc.expectedPath != "" {
                    paths := ingressRules[0].Path("http.paths").Children()
                    suite.Assertions.EqualValues(tc.expectedPath, paths[0].Path("path").Data())
                }
            } else {
                suite.Assertions.Empty(ingressManifest)
            }
        })
    }
}

func (suite *IngressTestSuite) TestPathServices() {
    tests := map[string]struct {
        values              []string
        expectedServiceName string
        expectedServicePort int
    }{
        "Default": {
            values:              []string{"ingress.main.enabled=true"},
            expectedServiceName: "common-test",
            expectedServicePort: 8080,
        },
        "CustomService": {
            values: []string{
                "service.main.ports.http.targetPort=80",
                "ingress.main.enabled=true",
                "ingress.main.hosts[0].host=test.local",
                "ingress.main.hosts[0].paths[0].path=/second/",
                "ingress.main.hosts[0].paths[0].service.name=pathService",
                "ingress.main.hosts[0].paths[0].service.port=1234",
            },
            expectedServiceName: "pathService",
            expectedServicePort: 1234,
        },
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            ingressManifest := suite.Chart.Manifests.Get("Ingress", "common-test")
            suite.Assertions.NotEmpty(ingressManifest)

            ingressRules := ingressManifest.Path("spec.rules").Children()
            paths := ingressRules[0].Path("http.paths").Children()
            primaryPath := paths[0]

            if tc.expectedServiceName == "" {
                suite.Assertions.Empty(primaryPath.Path("backend.service.name").Data())
            } else {
                suite.Assertions.EqualValues(tc.expectedServiceName, primaryPath.Path("backend.service.name").Data())
            }

            if tc.expectedServicePort == 0 {
                suite.Assertions.Empty(primaryPath.Path("backend.service.port.number").Data())
            } else {
                suite.Assertions.EqualValues(tc.expectedServicePort, primaryPath.Path("backend.service.port.number").Data())
            }
        })
    }
}

func (suite *IngressTestSuite) TestTLS() {
    tests := map[string]struct {
        values             []string
        expectedTLS        bool
        expectedHostName   string
        expectedSecretName string
    }{
        "Default": {
            values:      nil,
            expectedTLS: false,
        },
        "Provided": {
            values: []string{
                "ingress.main.enabled=true",
                "ingress.main.tls[0].hosts[0]=hostname",
                "ingress.main.tls[0].secretName=secret-name",
            },
            expectedTLS:        true,
            expectedHostName:   "hostname",
            expectedSecretName: "secret-name",
        },
        "NoSecret": {
            values: []string{
                "ingress.main.enabled=true",
                "ingress.main.tls[0].hosts[0]=hostname",
            },
            expectedTLS:        true,
            expectedHostName:   "hostname",
            expectedSecretName: "",
        },
        "SecretTemplate": {
            values: []string{
                "ingress.main.enabled=true",
                "ingress.main.tls[0].hosts[0]=hostname",
                `ingress.main.tls[0].secretName=\{\{ .Release.Name \}\}-secret`,
            },
            expectedTLS:        true,
            expectedHostName:   "hostname",
            expectedSecretName: "common-test-secret",
        },
    }
    for name, tc := range tests {
        suite.Suite.Run(name, func() {
            err := suite.Chart.Render(nil, tc.values, nil)
            if err != nil {
                suite.FailNow(err.Error())
            }

            ingressManifest := suite.Chart.Manifests.Get("Ingress", "common-test")

            if tc.expectedTLS {
                suite.Assertions.NotEmpty(ingressManifest.Path("spec.tls").Data())
                tlsSpec := ingressManifest.Path("spec.tls").Children()
                tlsHostsSpec := tlsSpec[0].Path("hosts").Children()
                suite.Assertions.EqualValues(tc.expectedHostName, tlsHostsSpec[0].Data())

                if tc.expectedSecretName == "" {
                    suite.Assertions.Empty(tlsSpec[0].Path("secretName").Data())
                } else {
                    suite.Assertions.EqualValues(tc.expectedSecretName, tlsSpec[0].Path("secretName").Data())
                }
            } else {
                suite.Assertions.Empty(ingressManifest.Path("spec.tls").Data())
            }
        })
    }
}
