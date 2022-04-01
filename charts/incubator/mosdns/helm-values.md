# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"601096721/mosdns"` |  |
| image.tag | string | `"v3.5.2@sha256:a9493f81c691aacd2c5f443e0e476fd839417ea2d256165807913d36cca63533"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/etc/mosdns"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `53` |  |
| service.main.ports.main.protocol | string | `"UDP"` |  |
| service.main.ports.main.targetPort | int | `53` |  |

All Rights Reserved - The TrueCharts Project
