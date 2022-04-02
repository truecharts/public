# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ALLOWED_DOMAINS | string | `""` |  |
| env.AWS_ACCESS_KEY_ID | string | `""` |  |
| env.AWS_REGION | string | `""` |  |
| env.AWS_S3_ACCELERATE_URL | string | `""` |  |
| env.AWS_S3_ACL | string | `""` |  |
| env.AWS_S3_FORCE_PATH_STYLE | bool | `true` |  |
| env.AWS_S3_UPLOAD_BUCKET_NAME | string | `""` |  |
| env.AWS_S3_UPLOAD_BUCKET_URL | string | `""` |  |
| env.AWS_S3_UPLOAD_MAX_SIZE | int | `26214400` |  |
| env.AWS_SECRET_ACCESS_KEY | string | `""` |  |
| env.AZURE_CLIENT_ID | string | `""` |  |
| env.AZURE_CLIENT_SECRET | string | `""` |  |
| env.AZURE_RESOURCE_APP_ID | string | `""` |  |
| env.COLLABORATION_URL | string | `""` |  |
| env.DEFAULT_LANGUAGE | string | `"en_US"` |  |
| env.ENABLE_UPDATES | bool | `true` |  |
| env.FORCE_HTTPS | bool | `false` |  |
| env.GOOGLE_ANALYTICS_ID | string | `""` |  |
| env.GOOGLE_CLIENT_ID | string | `""` |  |
| env.GOOGLE_CLIENT_SECRET | string | `""` |  |
| env.MAXIMUM_IMPORT_SIZE | int | `5120000` |  |
| env.OIDC_AUTH_URI | string | `""` |  |
| env.OIDC_CLIENT_ID | string | `""` |  |
| env.OIDC_CLIENT_SECRET | string | `""` |  |
| env.OIDC_DISPLAY_NAME | string | `""` |  |
| env.OIDC_SCOPES | string | `""` |  |
| env.OIDC_TOKEN_URI | string | `""` |  |
| env.OIDC_USERINFO_URI | string | `""` |  |
| env.OIDC_USERNAME_CLAIM | string | `""` |  |
| env.PGSSLMODE | string | `"disable"` |  |
| env.PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.SENTRY_DSN | string | `""` |  |
| env.SLACK_APP_ID | string | `""` |  |
| env.SLACK_KEY | string | `""` |  |
| env.SLACK_MESSAGE_ACTIONS | bool | `true` |  |
| env.SLACK_SECRET | string | `""` |  |
| env.SLACK_VERIFICATION_TOKEN | string | `""` |  |
| env.TEAM_LOGO | string | `""` |  |
| env.URL | string | `"http://localhost:{{ .Values.service.main.ports.main.port }}"` |  |
| env.WEB_CONCURRENCY | int | `1` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.key | string | `"url-noql"` |  |
| envValueFrom.DATABASE_URL.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_URL.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.REDIS_URL.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.SECRET_KEY.secretKeyRef.key | string | `"SECRET_KEY"` |  |
| envValueFrom.SECRET_KEY.secretKeyRef.name | string | `"outline-secrets"` |  |
| envValueFrom.UTILS_SECRET.secretKeyRef.key | string | `"UTILS_SECRET"` |  |
| envValueFrom.UTILS_SECRET.secretKeyRef.name | string | `"outline-secrets"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/outline"` |  |
| image.tag | string | `"v0.62.0@sha256:9350ace6f88ae314620ab32e9990481d0e89895409b171fa0545b8ef9f7ede65"` |  |
| installContainers.initdb.command[0] | string | `"sh"` |  |
| installContainers.initdb.command[1] | string | `"-c"` |  |
| installContainers.initdb.command[2] | string | `"yarn sequelize db:migrate --env=production-ssl-disabled"` |  |
| installContainers.initdb.env[0].name | string | `"DATABASE_URL"` |  |
| installContainers.initdb.env[0].valueFrom.secretKeyRef.key | string | `"url-noql"` |  |
| installContainers.initdb.env[0].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| installContainers.initdb.env[1].name | string | `"REDIS_URL"` |  |
| installContainers.initdb.env[1].valueFrom.secretKeyRef.key | string | `"url"` |  |
| installContainers.initdb.env[1].valueFrom.secretKeyRef.name | string | `"rediscreds"` |  |
| installContainers.initdb.env[2].name | string | `"SECRET_KEY"` |  |
| installContainers.initdb.env[2].valueFrom.secretKeyRef.key | string | `"SECRET_KEY"` |  |
| installContainers.initdb.env[2].valueFrom.secretKeyRef.name | string | `"outline-secrets"` |  |
| installContainers.initdb.env[3].name | string | `"UTILS_SECRET"` |  |
| installContainers.initdb.env[3].valueFrom.secretKeyRef.key | string | `"UTILS_SECRET"` |  |
| installContainers.initdb.env[3].valueFrom.secretKeyRef.name | string | `"outline-secrets"` |  |
| installContainers.initdb.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| minioImage.repository | string | `"tccr.io/truecharts/minio"` |  |
| minioImage.tag | string | `"latest@sha256:70816dc5a2b67795a0583e54d31f96e17fb8fcf436ac17e47b47fdfd7b9660a5"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"outline"` |  |
| postgresql.postgresqlUsername | string | `"outline"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10196` |  |
| upgradeContainers.upgradedb.command[0] | string | `"sh"` |  |
| upgradeContainers.upgradedb.command[1] | string | `"-c"` |  |
| upgradeContainers.upgradedb.command[2] | string | `"yarn sequelize db:migrate --env=production-ssl-disabled"` |  |
| upgradeContainers.upgradedb.env[0].name | string | `"DATABASE_URL"` |  |
| upgradeContainers.upgradedb.env[0].valueFrom.secretKeyRef.key | string | `"url-noql"` |  |
| upgradeContainers.upgradedb.env[0].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| upgradeContainers.upgradedb.env[1].name | string | `"REDIS_URL"` |  |
| upgradeContainers.upgradedb.env[1].valueFrom.secretKeyRef.key | string | `"url"` |  |
| upgradeContainers.upgradedb.env[1].valueFrom.secretKeyRef.name | string | `"rediscreds"` |  |
| upgradeContainers.upgradedb.env[2].name | string | `"SECRET_KEY"` |  |
| upgradeContainers.upgradedb.env[2].valueFrom.secretKeyRef.key | string | `"SECRET_KEY"` |  |
| upgradeContainers.upgradedb.env[2].valueFrom.secretKeyRef.name | string | `"outline-secrets"` |  |
| upgradeContainers.upgradedb.env[3].name | string | `"UTILS_SECRET"` |  |
| upgradeContainers.upgradedb.env[3].valueFrom.secretKeyRef.key | string | `"UTILS_SECRET"` |  |
| upgradeContainers.upgradedb.env[3].valueFrom.secretKeyRef.name | string | `"outline-secrets"` |  |
| upgradeContainers.upgradedb.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |

All Rights Reserved - The TrueCharts Project
