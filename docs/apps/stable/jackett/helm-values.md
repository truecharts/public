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
| image.repository | string | `"ghcr.io/k8s-at-home/jackett"` |  |
| image.tag | string | `"v0.18.899@sha256:717f7178f396557f3684e0b78198758e0197fb4f456ed5ef8a82dd8bbcacfae6"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| probes.liveness.path | string | `"/UI/Login"` |  |
| probes.readiness.path | string | `"/UI/Login"` |  |
| probes.startup.path | string | `"/UI/Login"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `9117` |  |

All Rights Reserved - The TrueCharts Project
