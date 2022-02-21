# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cronjob.annotations | object | `{}` |  |
| cronjob.failedJobsHistoryLimit | int | `5` |  |
| cronjob.schedule | string | `"*/5 * * * *"` |  |
| cronjob.successfulJobsHistoryLimit | int | `2` |  |
| env.POSTGRES_DB | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.POSTGRES_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.TRUSTED_PROXIES | string | `"172.16.0.0/16"` |  |
| envFrom[0].configMapRef.name | string | `"nextcloudconfig"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.key | string | `"plainporthost"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_HOST_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_HOST_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/nextcloud"` |  |
| image.tag | string | `"v23.0.2@sha256:a2b897413098ea9a54ab9308c9c645e96189a496a89550be249089f7853c8ed3"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/var/www/html"` |  |
| podSecurityContext.fsGroup | int | `33` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"nextcloud"` |  |
| postgresql.postgresqlUsername | string | `"nextcloud"` |  |
| probes.liveness.custom | bool | `true` |  |
| probes.liveness.spec.httpGet.httpHeaders[0].name | string | `"Host"` |  |
| probes.liveness.spec.httpGet.httpHeaders[0].value | string | `"test.fakedomain.dns"` |  |
| probes.liveness.spec.httpGet.path | string | `"/status.php"` |  |
| probes.liveness.spec.httpGet.port | int | `80` |  |
| probes.readiness.custom | bool | `true` |  |
| probes.readiness.spec.httpGet.httpHeaders[0].name | string | `"Host"` |  |
| probes.readiness.spec.httpGet.httpHeaders[0].value | string | `"test.fakedomain.dns"` |  |
| probes.readiness.spec.httpGet.path | string | `"/status.php"` |  |
| probes.readiness.spec.httpGet.port | int | `80` |  |
| probes.startup.custom | bool | `true` |  |
| probes.startup.spec.httpGet.httpHeaders[0].name | string | `"Host"` |  |
| probes.startup.spec.httpGet.httpHeaders[0].value | string | `"test.fakedomain.dns"` |  |
| probes.startup.spec.httpGet.path | string | `"/status.php"` |  |
| probes.startup.spec.httpGet.port | int | `80` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| secret.NEXTCLOUD_ADMIN_PASSWORD | string | `"adminpass"` |  |
| secret.NEXTCLOUD_ADMIN_USER | string | `"admin"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.hpb.enabled | bool | `true` |  |
| service.hpb.ports.hpb.enabled | bool | `true` |  |
| service.hpb.ports.hpb.port | int | `7867` |  |
| service.hpb.ports.hpb.targetPort | int | `7867` |  |
| service.main.ports.main.port | int | `10020` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
