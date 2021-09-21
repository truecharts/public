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
| env.NEXTCLOUD_ADMIN_PASSWORD | string | `"adminpass"` |  |
| env.NEXTCLOUD_ADMIN_USER | string | `"admin"` |  |
| env.TRUSTED_PROXIES | string | `"172.16.0.0/16"` |  |
| envFrom[0].configMapRef.name | string | `"nextcloudconfig"` |  |
| envTpl.POSTGRES_DB | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| envTpl.POSTGRES_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.key | string | `"host"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"masterhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_HOST_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_HOST_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"docker.io/nextcloud"` |  |
| image.tag | string | `"22.1.1@sha256:99d94124b2024c9f7f38dc12144a92bc0d68d110bcfd374169ebb7e8df0adf8e"` |  |
| initContainers.init-postgresdb.command[0] | string | `"sh"` |  |
| initContainers.init-postgresdb.command[1] | string | `"-c"` |  |
| initContainers.init-postgresdb.command[2] | string | `"until pg_isready -U nextcloud -h ${pghost} ; do sleep 2 ; done"` |  |
| initContainers.init-postgresdb.env[0].name | string | `"pghost"` |  |
| initContainers.init-postgresdb.env[0].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| initContainers.init-postgresdb.env[0].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| initContainers.init-postgresdb.image | string | `"{{ .Values.postgresqlImage.repository}}:{{ .Values.postgresqlImage.tag }}"` |  |
| initContainers.init-postgresdb.imagePullPolicy | string | `"IfNotPresent"` |  |
| persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/var/www/html"` |  |
| persistence.data.size | string | `"100Gi"` |  |
| persistence.data.type | string | `"pvc"` |  |
| persistence.redismaster.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.redismaster.enabled | bool | `true` |  |
| persistence.redismaster.forceName | string | `"redismaster"` |  |
| persistence.redismaster.noMount | bool | `true` |  |
| persistence.redismaster.size | string | `"100Gi"` |  |
| persistence.redismaster.type | string | `"pvc"` |  |
| podSecurityContext.fsGroup | int | `33` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| podSecurityContext.supplementalGroups | list | `[]` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"nextcloud"` |  |
| postgresql.postgresqlUsername | string | `"nextcloud"` |  |
| postgresqlImage.pullPolicy | string | `"IfNotPresent"` |  |
| postgresqlImage.repository | string | `"bitnami/postgresql"` |  |
| postgresqlImage.tag | string | `"13.4.0@sha256:abfb7efd31afc36a8b16aa077bb9dd165c4f635412affef37c7859605fda762c"` |  |
| probes | object | See below | Probe configuration -- [[ref]](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| probes.liveness | object | See below | Liveness probe configuration |
| probes.liveness.spec | object | "/" | If a HTTP probe is used (default for HTTP/HTTPS services) this path is used |
| probes.readiness | object | See below | Redainess probe configuration |
| probes.readiness.spec | object | "/" | If a HTTP probe is used (default for HTTP/HTTPS services) this path is used |
| probes.startup | object | See below | Startup probe configuration |
| probes.startup.spec | object | "/" | If a HTTP probe is used (default for HTTP/HTTPS services) this path is used |
| redis.architecture | string | `"standalone"` |  |
| redis.auth.existingSecret | string | `"rediscreds"` |  |
| redis.auth.existingSecretPasswordKey | string | `"redis-password"` |  |
| redis.enabled | bool | `true` |  |
| redis.master.persistence.enabled | bool | `false` |  |
| redis.master.persistence.existingClaim | string | `"redismaster"` |  |
| redis.replica.persistence.enabled | bool | `false` |  |
| redis.replica.replicaCount | int | `0` |  |
| redis.volumePermissions.enabled | bool | `true` |  |
| service.hpb.enabled | bool | `true` |  |
| service.hpb.ports.hpb.enabled | bool | `true` |  |
| service.hpb.ports.hpb.port | int | `7867` |  |
| service.main.ports.main.port | int | `80` |  |

All Rights Reserved - The TrueCharts Project
