# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.MYSQL_USERNAME | string | `"clarkson"` |  |
| env.PUID | int | `568` |  |
| envValueFrom.MYSQL_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.MYSQL_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.MYSQL_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.MYSQL_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/clarkson"` |  |
| image.tag | string | `"v1.1.2@sha256:cfbc3aca546a36a74d62969511c0bbc1aad521867610faf502ee8abe0dbe3258"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"clarkson"` |  |
| mariadb.mariadbUsername | string | `"clarkson"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10113` |  |
| service.main.ports.main.targetPort | int | `3000` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
