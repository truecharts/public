# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| args[0] | string | `"--port"` |  |
| args[1] | string | `"8080"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"traefik/whoami"` |  |
| image.tag | string | `"v1.6.1@sha256:16012fe4680ce69348d98627c7d42c1ea5ffde7bc4d66aaae426bd8d05af0d84"` |  |
| service.main.ports.main.port | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
