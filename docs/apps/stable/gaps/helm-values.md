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
| image.repository | string | `"tccr.io/truecharts/gaps"` |  |
| image.tag | string | `"v0.8.8@sha256:7f7d33e4279f55bfaf5ea1a7e071b4266794052eddaba2294ab29be45a2133bf"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/usr/data"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `8484` |  |
| service.main.ports.main.targetPort | int | `8484` |  |

All Rights Reserved - The TrueCharts Project
