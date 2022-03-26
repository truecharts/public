# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ADMIN_EMAILS | string | `"admin@example.com,admin@example2.com"` |  |
| env.CONTACT_EMAIL | string | `"admin@example.com"` |  |
| env.CUSTOM_DOMAIN_USE_HTTPS | bool | `false` |  |
| env.DB_NAME | string | `"kutt"` |  |
| env.DB_PORT | string | `"5432"` |  |
| env.DB_USER | string | `"kutt"` |  |
| env.DEFAULT_DOMAIN | string | `"localhost:{{ .Values.service.main.ports.main.port }}"` |  |
| env.DEFAULT_MAX_STATS_PER_LINK | int | `5000` |  |
| env.DISALLOW_ANONYMOUS_LINKS | bool | `false` |  |
| env.DISALLOW_REGISTRATION | bool | `false` |  |
| env.LINK_LENGTH | int | `6` |  |
| env.MAIL_FROM | string | `""` |  |
| env.MAIL_HOST | string | `""` |  |
| env.MAIL_PORT | int | `567` |  |
| env.MAIL_SECURE | bool | `true` |  |
| env.NON_USER_COOLDOWN | int | `0` |  |
| env.PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.REDIS_PORT | string | `"6379"` |  |
| env.REPORT_EMAIL | string | `"admin@example.com"` |  |
| env.SITE_NAME | string | `"My Kutt Instance"` |  |
| env.USER_LIMIT_PER_DAY | int | `50` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.JWT_SECRET.secretKeyRef.key | string | `"JWT_SECRET"` |  |
| envValueFrom.JWT_SECRET.secretKeyRef.name | string | `"kutt-secrets"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/kutt"` |  |
| image.tag | string | `"v2.7.4@sha256:7b89481d467e1c1dc75e672bdac18dd00fdb4a3f0b60d90518acbf8eddfe8615"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"kutt"` |  |
| postgresql.postgresqlUsername | string | `"kutt"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| secret.GOOGLE_ANALYTICS | string | `""` |  |
| secret.GOOGLE_ANALYTICS_UNIVERSAL | string | `""` |  |
| secret.GOOGLE_SAFE_BROWSING_KEY | string | `""` |  |
| secret.MAIL_PASSWORD | string | `""` |  |
| secret.MAIL_USER | string | `""` |  |
| secret.RECAPTCHA_SECRET_KEY | string | `""` |  |
| secret.RECAPTCHA_SITE_KEY | string | `""` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10195` |  |

All Rights Reserved - The TrueCharts Project
