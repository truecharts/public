# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.APACHE_HTTPS_PORT_NUMBER | string | `"{{ .Values.service.https.ports.https.port }}"` |  |
| env.APACHE_HTTP_PORT_NUMBER | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.BITNAMI_DEBUG | bool | `true` |  |
| env.MATOMO_DATABASE_NAME | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.MATOMO_DATABASE_PORT_NUMBER | int | `3306` |  |
| env.MATOMO_DATABASE_USER | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.MATOMO_EMAIL | string | `"myemail@example.com"` |  |
| env.MATOMO_ENABLE_ASSUME_SECURE_PROTOCOL | bool | `false` |  |
| env.MATOMO_ENABLE_FORCE_SSL | bool | `false` |  |
| env.MATOMO_ENABLE_PROXY_URI_HEADER | bool | `false` |  |
| env.MATOMO_HOST | string | `"127.0.0.1"` |  |
| env.MATOMO_PASSWORD | string | `"password"` |  |
| env.MATOMO_SMTP_AUTH | string | `"Plain"` |  |
| env.MATOMO_SMTP_HOST | string | `""` |  |
| env.MATOMO_SMTP_PASSWORD | string | `""` |  |
| env.MATOMO_SMTP_PORT | string | `""` |  |
| env.MATOMO_SMTP_PROTOCOL | string | `""` |  |
| env.MATOMO_SMTP_USER | string | `""` |  |
| env.MATOMO_USERNAME | string | `"admin"` |  |
| env.MATOMO_WEBSITE_HOST | string | `"https://web.example.com"` |  |
| env.MATOMO_WEBSITE_NAME | string | `"My Website"` |  |
| env.PHP_DATE_TIMEZONE | string | `"{{ .Values.TZ }}"` |  |
| env.PHP_ENABLE_OPCACHE | bool | `true` |  |
| env.PHP_MEMORY_LIMIT | string | `"2048M"` |  |
| envValueFrom.MATOMO_DATABASE_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.MATOMO_DATABASE_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.MATOMO_DATABASE_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.MATOMO_DATABASE_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/matomo"` |  |
| image.tag | string | `"v4.8.0@sha256:2b10e3a56bd1278f706f02ec345e7eace5d9ce8ff320a61923115510cb6cfcbe"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"matomo"` |  |
| mariadb.mariadbUsername | string | `"matomo"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/bitnami/matomo"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| probes.liveness.path | string | `"/index.php"` |  |
| probes.readiness.path | string | `"/index.php"` |  |
| probes.startup.path | string | `"/index.php"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.https.enabled | bool | `true` |  |
| service.https.ports.https.enabled | bool | `true` |  |
| service.https.ports.https.port | int | `10173` |  |
| service.https.ports.https.protocol | string | `"HTTPS"` |  |
| service.https.ports.https.targetPort | int | `10173` |  |
| service.main.ports.main.port | int | `10172` |  |
| service.main.ports.main.protocol | string | `"HTTP"` |  |
| service.main.ports.main.targetPort | int | `10172` |  |

All Rights Reserved - The TrueCharts Project
