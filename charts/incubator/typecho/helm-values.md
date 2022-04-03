# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.MAX_POST_BODY | string | `"50M"` |  |
| env.MEMORY_LIMIT | string | `"100M"` |  |
| env.TIMEZONE | string | `"{{ .Values.TZ }}"` |  |
| env.TYPECHO_DB_ADAPTER | string | `"Pdo_Mysql"` |  |
| env.TYPECHO_DB_CHARSET | string | `"utf8mb4"` |  |
| env.TYPECHO_DB_DATABASE | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.TYPECHO_DB_ENGINE | string | `"InnoDB"` |  |
| env.TYPECHO_DB_NEXT | string | `"none"` |  |
| env.TYPECHO_DB_PORT | string | `"3306"` |  |
| env.TYPECHO_DB_PREFIX | string | `"typecho_"` |  |
| env.TYPECHO_DB_USER | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.TYPECHO_INSTALL | int | `1` |  |
| env.TYPECHO_SITE_URL | string | `"https://your-domain.com"` |  |
| env.TYPECHO_USER_MAIL | string | `"test@truecharts.org"` |  |
| env.TYPECHO_USER_NAME | string | `"typecho"` |  |
| env.TYPECHO_USER_PASSWORD | string | `"testtypecho"` |  |
| envValueFrom.TYPECHO_DB_HOST.secretKeyRef.key | string | `"plainporthost"` |  |
| envValueFrom.TYPECHO_DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.TYPECHO_DB_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.TYPECHO_DB_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"joyqi/typecho"` |  |
| image.tag | string | `"1.2.0-php8.0-apache@sha256:090f5aad01ff81ecb6272368612d2b7d0887065da850ae8d094a137b231bdd84"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"typecho"` |  |
| mariadb.mariadbUsername | string | `"typecho"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/app/usr"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10207` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
