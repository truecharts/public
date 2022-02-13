# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers.frontend.image | string | `"{{ .Values.frontendImage.repository }}:{{ .Values.frontendImage.tag }}"` |  |
| additionalContainers.frontend.name | string | `"frontend"` |  |
| additionalContainers.proxy.image | string | `"{{ .Values.proxyImage.repository }}:{{ .Values.proxyImage.tag }}"` |  |
| additionalContainers.proxy.name | string | `"proxy"` |  |
| additionalContainers.proxy.ports[0].containerPort | int | `80` |  |
| additionalContainers.proxy.ports[0].name | string | `"main"` |  |
| additionalContainers.proxy.volumeMounts[0].mountPath | string | `"/etc/nginx/nginx.conf"` |  |
| additionalContainers.proxy.volumeMounts[0].name | string | `"librephotos-config"` |  |
| additionalContainers.proxy.volumeMounts[0].readOnly | bool | `true` |  |
| additionalContainers.proxy.volumeMounts[0].subPath | string | `"nginx-config"` |  |
| additionalContainers.proxy.volumeMounts[1].mountPath | string | `"/data"` |  |
| additionalContainers.proxy.volumeMounts[1].name | string | `"media"` |  |
| additionalContainers.proxy.volumeMounts[2].mountPath | string | `"/protected_media"` |  |
| additionalContainers.proxy.volumeMounts[2].name | string | `"protected-media"` |  |
| env.BACKEND_HOST | string | `"localhost"` |  |
| env.DB_BACKEND | string | `"postgresql"` |  |
| env.DB_NAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_PORT | string | `"5432"` |  |
| env.DB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.DEBUG | int | `0` |  |
| env.HEAVYWEIGHT_PROCESS | int | `1` |  |
| env.REDIS_PORT | string | `"6379"` |  |
| env.SKIP_PATTERNS | string | `""` |  |
| env.TZ | string | `"UTC"` |  |
| env.WEB_CONCURRENCY | int | `2` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASS.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASS.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PASS.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PASS.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.SECRET_KEY.secretKeyRef.key | string | `"SECRET_KEY"` |  |
| envValueFrom.SECRET_KEY.secretKeyRef.name | string | `"librephotos-secrets"` |  |
| frontendImage.repository | string | `"tccr.io/truecharts/librephotos-frontend"` |  |
| frontendImage.tag | string | `"v2022w06@sha256:9cb2cb4865197d460405fecd79bdd7808333443cb2089753825f7f97365a53a3"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/librephotos-backend"` |  |
| image.tag | string | `"v2022w06@sha256:4c24ce4ea5b340f83da0be0935eaea4ca525a15ed6da014f8ad8c709b377a837"` |  |
| persistence.cache.enabled | bool | `true` |  |
| persistence.cache.mountPath | string | `"/root/.cache"` |  |
| persistence.logs.enabled | bool | `true` |  |
| persistence.logs.mountPath | string | `"/logs"` |  |
| persistence.media.enabled | bool | `true` |  |
| persistence.media.mountPath | string | `"/data"` |  |
| persistence.protected-media.enabled | bool | `true` |  |
| persistence.protected-media.mountPath | string | `"/protected_media"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"librephotos"` |  |
| postgresql.postgresqlUsername | string | `"librephotos"` |  |
| probes.liveness.path | string | `"/login"` |  |
| probes.readiness.path | string | `"/login"` |  |
| probes.startup.path | string | `"/login"` |  |
| proxyImage.repository | string | `"tccr.io/truecharts/librephotos-proxy"` |  |
| proxyImage.tag | string | `"v2022w06@sha256:c147eaa3e96348e44132958ca871114a2ce240f0fa3604f738801317af09a160"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| redis.redisUsername | string | `"default"` |  |
| secret.ADMIN_EMAIL | string | `"admin@mydomain.com"` |  |
| secret.ADMIN_PASSWORD | string | `"password"` |  |
| secret.ADMIN_USERNAME | string | `"admin"` |  |
| secret.MAPBOX_API_KEY | string | `""` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10161` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
