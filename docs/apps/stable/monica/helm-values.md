# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [monica documentation](https://raw.githubusercontent.com/monicahq/monica/master/.env.example) for more details. |
| env.APP_ENV | string | `"production"` | Use `local` if you want to install Monica as a development version. Use `production` otherwise. |
| env.APP_URL | string | `"https://crm.k8s-at-home.com"` | The URL of your application. |
| envValueFrom.APP_KEY.secretKeyRef.key | string | `"appkey"` |  |
| envValueFrom.APP_KEY.secretKeyRef.name | string | `"appkey"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/monica"` |  |
| image.tag | string | `"v3.7.0@sha256:030f4c368bcff3b3ed3bcdbc3dbd767b30ed39e7e02796e08dad3685fda6e4b4"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"monica"` |  |
| mariadb.mariadbUsername | string | `"monica"` |  |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
