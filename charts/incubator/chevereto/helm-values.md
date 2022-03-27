# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| chevereto.disable_update_cli | bool | `true` |  |
| chevereto.disable_update_http | bool | `true` |  |
| chevereto.https | bool | `false` |  |
| configmap.chevereto.data.CHEVERETO_DISABLE_UPDATE_CLI | string | `"{{ ternary \"1\" \"0\" .Values.chevereto.disable_update_cli }}"` |  |
| configmap.chevereto.data.CHEVERETO_DISABLE_UPDATE_HTTP | string | `"{{ ternary \"1\" \"0\" .Values.chevereto.disable_update_http }}"` |  |
| configmap.chevereto.data.CHEVERETO_HTTPS | string | `"{{ ternary \"1\" \"0\" .Values.chevereto.https }}"` |  |
| configmap.chevereto.enabled | bool | `true` |  |
| env.CHEVERETO_DB_DRIVER | string | `"mysql"` |  |
| env.CHEVERETO_DB_NAME | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.CHEVERETO_DB_PORT | string | `"3306"` |  |
| env.CHEVERETO_DB_USER | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.CHEVERETO_TAG | string | `"free"` |  |
| envFrom[0].configMapRef.name | string | `"{{ include \"common.names.fullname\" . }}-chevereto"` |  |
| envValueFrom.CHEVERETO_DB_HOST.secretKeyRef.key | string | `"plainporthost"` |  |
| envValueFrom.CHEVERETO_DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.CHEVERETO_DB_PASS.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.CHEVERETO_DB_PASS.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/chevereto"` |  |
| image.tag | string | `"v1.6.2@sha256:6f9c2d7a86d97d4de70995ac258441a07806a328d7ba7b0ae65a965d590dae43"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"chevereto"` |  |
| mariadb.mariadbUsername | string | `"chevereto"` |  |
| persistence.content.enabled | bool | `true` |  |
| persistence.content.mountPath | string | `"/var/www/html/content/"` |  |
| persistence.storage.enabled | bool | `true` |  |
| persistence.storage.mountPath | string | `"/var/www/html/images/"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10197` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
