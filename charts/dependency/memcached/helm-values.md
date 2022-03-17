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
| image.tag | string | `"v1.6.14@sha256:20aecf4e0ede438c377c91fd7ec90e995dfc551ef76f2914175b37e97ef248e6"` |  |
| service.main.ports.main.port | int | `11211` |  |
| service.main.ports.main.targetPort | int | `11211` |  |

All Rights Reserved - The TrueCharts Project
