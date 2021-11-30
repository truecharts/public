# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See more environment variables in the [icinga2 documentation](https://github.com/jjethwa/icinga2#environment-variables-reference). |
| envValueFrom.DEFAULT_MYSQL_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DEFAULT_MYSQL_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.DEFAULT_MYSQL_PASS.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.DEFAULT_MYSQL_PASS.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.MYSQL_ROOT_PASSWORD.secretKeyRef.key | string | `"mariadb-root-password"` |  |
| envValueFrom.MYSQL_ROOT_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"jordan/icinga2"` |  |
| image.tag | string | `"2.13.1@sha256:00a826bee739d06be6999b493254d9e474875de8c842219a18cee99c01e84760"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"icinga2"` |  |
| mariadb.mariadbUsername | string | `"icinga2"` |  |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| persistence.config | object | Disabled | Icinga2 configuration folder |
| persistence.data | object | Disabled | Icinga2 Data |
| persistence.ssmtp | object | Disabled | ssmtp folder |
| persistence.web | object | Disabled | Icingaweb2 configuration folder |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
