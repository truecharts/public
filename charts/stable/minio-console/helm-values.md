# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| args | list | `["server"]` | Override the args for the default container. |
| env | object | See below | environment variables. See more environment variables in the [minio-console documentation](https://minio-console.org/docs). |
| env.CONSOLE_MINIO_SERVER | string | `""` | Required: Minio server URL Example: https://minio.server:9000 |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"minio/console"` | image repository |
| image.tag | string | `"v0.12.4@sha256:d14878133c2de31fad0b590eb6f7cb6420abf8f1f4ebb1d4e9b804363ea3e658"` | image tag |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| secret.CONSOLE_PBKDF_PASSPHRASE | string | `"changeme"` | Required: Passphrase to derive keys (generate own) Example: D6vpras1xpUgrcFpOIGA4crHvzUDQb48 |
| secret.CONSOLE_PBKDF_SALT | string | `"changeme"` | Required: Salt for derived keys (generate own) Example: ILy2FWzwjjYi1TeTEpBjEsPrwLfKZxgi |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
