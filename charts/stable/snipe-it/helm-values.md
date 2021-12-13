# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.MYSQL_DATABASE | string | `"snipe-it"` |  |
| env.MYSQL_PORT_3306_TCP_PORT | string | `"3306"` |  |
| env.MYSQL_USER | string | `"snipe-it"` |  |
| env.NGINX_APP_URL | string | `"{{ include \"common.names.fullname\" . }}:8080"` |  |
| env.PUID | int | `568` |  |
| envValueFrom.MYSQL_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.MYSQL_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.MYSQL_PORT_3306_TCP_ADDR.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.MYSQL_PORT_3306_TCP_ADDR.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/snipe-it"` |  |
| image.tag | string | `"v5.3.3@sha256:e4e26d777996c34fba581dcb26f05843ece36797f032a01df7fed1f1e32898cb"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"snipe-it"` |  |
| mariadb.mariadbUsername | string | `"snipe-it"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret | object | `{}` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10120` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
