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
| image.repository | string | `"tccr.io/truecharts/alist"` |  |
| image.tag | string | `"v2.2.0@sha256:d0d149fa86bcdff30ad468b2a96bac3efabbecfbde0f6adf6c0a9250a59bd83a"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/opt/alist/data"` |  |
| service.main.ports.main.port | int | `10167` |  |
| service.main.ports.main.targetPort | int | `5244` |  |

All Rights Reserved - The TrueCharts Project
