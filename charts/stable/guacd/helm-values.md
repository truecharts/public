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
| image.repository | string | `"tccr.io/truecharts/guacamole-server"` |  |
| image.tag | string | `"v1.4.0@sha256:6b67e159e4e24524bf025a419062249763967085f6111d73d9f3d9ee7b0c13ee"` |  |
| service.main.ports.main.port | int | `4822` |  |
| service.main.ports.main.targetPort | int | `4822` |  |

All Rights Reserved - The TrueCharts Project
