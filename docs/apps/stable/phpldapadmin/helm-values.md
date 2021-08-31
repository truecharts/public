# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.PHPLDAPADMIN_HTTPS | string | `"false"` |  |
| env.PHPLDAPADMIN_TRUST_PROXY_SSL | string | `"true"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"osixia/phpldapadmin"` |  |
| image.tag | string | `"0.9.0"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `80` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
