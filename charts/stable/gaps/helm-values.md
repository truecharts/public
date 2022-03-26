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
| image.tag | string | `"v0.9.12@sha256:ccd1d53b06dcae58927b338845bac060c6346cf01542c039c630201df328b51f"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/usr/data"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `8484` |  |
| service.main.ports.main.targetPort | int | `8484` |  |

All Rights Reserved - The TrueCharts Project
