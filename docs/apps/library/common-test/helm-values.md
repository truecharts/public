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
| image.repository | string | `"tccr.io/truecharts/whoami"` |  |
| image.tag | string | `"v1.6.1@sha256:8237a50770d438e4daecbc5fca4ea981fc19daa0a6efa9b4a8a3a6e5a7a40666"` |  |
| service.main.ports.main.port | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
