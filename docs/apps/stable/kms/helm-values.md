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
| image.repository | string | `"pykmsorg/py-kms"` |  |
| image.tag | string | `"minimal@sha256:f60edd7b3e7d59b5a2759584a3bf844cf41a3f1a1346186bb77409e0cb0a143c"` |  |
| service.main.ports.main.port | int | `1688` |  |
| service.main.ports.main.protocol | string | `"TCP"` |  |

All Rights Reserved - The TrueCharts Project
