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
| image.repository | string | `"ghcr.io/truecharts/memcached"` |  |
| image.tag | string | `"v1.6.12@sha256:5c38fd5bfa575c3fc7085fc395437b90c1617da9749b606dc706d45d67b7a2c5"` |  |
| service.main.ports.main.port | int | `11211` |  |
| service.main.ports.main.targetPort | int | `11211` |  |

All Rights Reserved - The TrueCharts Project
