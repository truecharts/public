# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.POSTGRES_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.POSTGRES_PORT | int | `5432` |  |
| env.POSTGRES_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.REDIS_DB | string | `"0"` |  |
| env.REDIS_PORT | int | `6379` |  |
| env.TZ | string | `"UTC"` |  |
| env.WEBLATE_TIME_ZONE | string | `"{{ .Values.env.TZ }}"` |  |
| envFrom[0].configMapRef.name | string | `"weblate-env"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/weblate"` |  |
| image.tag | string | `"v4.10.1@sha256:bc517880487a9a766a3ce4ddfe429ed37ad4605d0097e28b0dd16eafdacd12b2"` |  |
| persistence.cache.enabled | bool | `true` |  |
| persistence.cache.mountPath | string | `"/app/cache"` |  |
| persistence.cache.type | string | `"emptyDir"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/app/data"` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsUser | int | `1000` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"weblate"` |  |
| postgresql.postgresqlUsername | string | `"weblate"` |  |
| probes.liveness.path | string | `"/healthz"` |  |
| probes.readiness.path | string | `"/healthz"` |  |
| probes.startup.path | string | `"/healthz"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| redis.redisUsername | string | `"default"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `10158` |  |
| service.main.ports.main.targetPort | int | `8080` |  |
| weblate.auth.azure | object | `{}` |  |
| weblate.auth.azuretenant | object | `{}` |  |
| weblate.auth.bitbucket | object | `{}` |  |
| weblate.auth.facebook | object | `{}` |  |
| weblate.auth.github | object | `{}` |  |
| weblate.auth.gitlab | object | `{}` |  |
| weblate.auth.google | object | `{}` |  |
| weblate.auth.keycloak | object | `{}` |  |
| weblate.auth.ldap | object | `{}` |  |
| weblate.auth.linux | object | `{}` |  |
| weblate.auth.saml | object | `{}` |  |
| weblate.auth.slack | object | `{}` |  |
| weblate.email | object | `{}` |  |
| weblate.errorreport | object | `{}` |  |
| weblate.general.WEBLATE_DEBUG | string | `"false"` |  |
| weblate.general.WEBLATE_SITE_DOMAIN | string | `"weblate.example.com"` |  |
| weblate.general.WEBLATE_SITE_TITLE | string | `"My Project's Weblate"` |  |
| weblate.localization | object | `{}` |  |
| weblate.machinetranslate | object | `{}` |  |
| weblate.siteintegration | object | `{}` |  |

All Rights Reserved - The TrueCharts Project
