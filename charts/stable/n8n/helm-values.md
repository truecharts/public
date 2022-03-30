# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| credentials | object | `{}` |  |
| deployment | object | `{"N8N_HOST":"localhost"}` |  CREDENTIALS_OVERWRITE_ENDPOINT: "" CREDENTIALS_DEFAULT_NAME: "My credentials" |
| endpoints | object | `{}` |  |
| env.DB_POSTGRESDB_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_POSTGRESDB_PORT | int | `5432` |  |
| env.DB_POSTGRESDB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.DB_TYPE | string | `"postgresdb"` |  |
| env.GENERIC_TIMEZONE | string | `"{{ .Values.TZ }}"` |  |
| env.N8N_USER_FOLDER | string | `"/data"` |  |
| env.QUEUE_BULL_REDIS_PORT | int | `6379` |  |
| envFrom[0].configMapRef.name | string | `"n8n-config"` |  |
| envValueFrom.DB_POSTGRESDB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_POSTGRESDB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_POSTGRESDB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_POSTGRESDB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.QUEUE_BULL_REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.QUEUE_BULL_REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.QUEUE_BULL_REDIS_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.QUEUE_BULL_REDIS_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| executions | object | `{}` |  N8N_PAYLOAD_SIZE_MAX: 16 N8N_METRICS: false N8N_METRICS_PREFIX: "n8n_" N8N_ENDPOINT_REST: "rest" N8N_ENDPOINT_WEBHOOK: "webhook" N8N_ENDPOINT_WEBHOOK_TEST: "webhook-test" N8N_ENDPOINT_WEBHOOK_WAIT: "webhook-waiting" N8N_DISABLE_PRODUCTION_MAIN_PROCESS: false N8N_SKIP_WEBHOOK_DEREGISTRATION_SHUTDOWN: false |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/n8n"` |  |
| image.tag | string | `"v0.170.0@sha256:bd1df50c3319a47bb5323b6d83ee1da50eea5717a4621d15c07ecfc97ab99cd5"` |  |
| logs | object | `{"N8N_LOG_FILE_LOCATION":"/data/logs"}` |  EXECUTIONS_MODE: "regular" EXECUTIONS_TIMEOUT: "-1" EXECUTIONS_TIMEOUT_MAX: 3600 EXECUTIONS_DATA_SAVE_ON_ERROR: "all" EXECUTIONS_DATA_SAVE_ON_SUCCESS: "all" EXECUTIONS_DATA_SAVE_ON_PROGRESS: false EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS: false EXECUTIONS_DATA_PRUNE: false EXECUTIONS_DATA_MAX_AGE: 336 EXECUTIONS_DATA_PRUNE_TIMEOUT: 3600 |
| logs.N8N_LOG_FILE_LOCATION | string | `"/data/logs"` |  N8N_LOG_OUTPUT: "console" N8N_LOG_FILE_COUNT_MAX: 100 N8N_LOG_FILE_SIZE_MAX: 16 |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"n8n"` |  |
| postgresql.postgresqlUsername | string | `"n8n"` |  |
| probes.liveness.path | string | `"/healthz"` |  |
| probes.readiness.path | string | `"/healthz"` |  |
| probes.startup.path | string | `"/healthz"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| security | object | `{}` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `5678` |  |
| service.main.ports.main.targetPort | int | `5678` |  |
| workflows | object | `{}` |  N8N_BASIC_AUTH_ACTIVE: false N8N_BASIC_AUTH_USER: "" N8N_BASIC_AUTH_PASSWORD: "" N8N_BASIC_AUTH_HASH: false N8N_JWT_AUTH_ACTIVE: false N8N_JWT_AUTH_HEADER: "" N8N_JWT_AUTH_HEADER_VALUE_PREFIX: "" N8N_JWKS_URI: "" N8N_JWT_ISSUER: "" N8N_JWT_NAMESPACE: "" N8N_JWT_ALLOWED_TENANT: "" N8N_JWT_ALLOWED_TENANT_KEY: "" |

All Rights Reserved - The TrueCharts Project
