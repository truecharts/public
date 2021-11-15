# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/k8s-at-home/nzbhydra2"` |  |
| image.tag | string | `"v3.17.3@sha256:9c1a08356359e75051b03ec614b4df5f6f24558a183de6feacb3a5c2ff232b77"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| probes.liveness.custom | bool | `true` |  |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `5` |  |
| probes.liveness.spec.httpGet.path | string | `"/actuator/health/livenessState"` |  |
| probes.liveness.spec.httpGet.port | string | `"main"` |  |
| probes.liveness.spec.initialDelaySeconds | int | `30` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.timeoutSeconds | int | `10` |  |
| probes.readiness.custom | bool | `true` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `5` |  |
| probes.readiness.spec.httpGet.path | string | `"/actuator/health/readinessState"` |  |
| probes.readiness.spec.httpGet.port | string | `"main"` |  |
| probes.readiness.spec.initialDelaySeconds | int | `30` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.timeoutSeconds | int | `10` |  |
| probes.startup.custom | bool | `true` |  |
| probes.startup.enabled | bool | `true` |  |
| probes.startup.spec.failureThreshold | int | `5` |  |
| probes.startup.spec.httpGet.path | string | `"/actuator/health/readinessState"` |  |
| probes.startup.spec.httpGet.port | string | `"main"` |  |
| probes.startup.spec.initialDelaySeconds | int | `30` |  |
| probes.startup.spec.periodSeconds | int | `10` |  |
| probes.startup.spec.timeoutSeconds | int | `10` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `5076` |  |
| service.main.ports.main.targetPort | int | `5076` |  |

All Rights Reserved - The TrueCharts Project
