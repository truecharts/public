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
| image.repository | string | `"tccr.io/truecharts/ddns-go"` |  |
| image.tag | string | `"v3.5.0@sha256:47126c3903118731d3958c7fb9a81c1beb762645c5f77137835bffa9b95a728e"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/root"` |  |
| service.main.ports.main.port | int | `10168` |  |
| service.main.ports.main.targetPort | int | `9876` |  |

All Rights Reserved - The TrueCharts Project
