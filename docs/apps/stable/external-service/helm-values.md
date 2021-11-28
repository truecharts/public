# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controller.enabled | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/truecharts/bs"` |  |
| image.tag | string | `"v0.66.6@sha256:666"` |  |
| service.main.externalIP | string | `"1.1.1.1"` |  |
| service.main.ports.main.Type | string | `"HTTPS"` |  |
| service.main.ports.main.port | int | `443` |  |
| service.main.ports.main.targetPort | int | `443` |  |
| service.main.type | string | `"ExternalIP"` |  |

All Rights Reserved - The TrueCharts Project
