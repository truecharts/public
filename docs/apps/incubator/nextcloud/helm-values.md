# nextcloud

![Version: 3.5.2](https://img.shields.io/badge/Version-3.5.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: auto](https://img.shields.io/badge/AppVersion-auto-informational?style=flat-square)

A private cloud server that puts the control and security of your own data back into your hands.

**Homepage:** <https://nextcloud.com/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| TrueCharts | info@truecharts.org | truecharts.org |

## Source Code

* <https://github.com/nextcloud/docker>
* <https://github.com/nextcloud/helm>

## Requirements

Kubernetes: `>=1.16.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | redis | 15.0.4 |
| https://truecharts.org/ | common | 6.12.1 |
| https://truecharts.org/ | postgresql | 1.5.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers[0].args[0] | string | `"while [ ! -f \"/var/www/html/custom_apps/notify_push/bin/x86_64/notify_push\" ]; do sleep 30; echo \"notify_push not found, waiting\"; done && /var/www/html/custom_apps/notify_push/bin/x86_64/notify_push /var/www/html/config/config.php"` |  |
| additionalContainers[0].command[0] | string | `"/bin/bash"` |  |
| additionalContainers[0].command[1] | string | `"-c"` |  |
| additionalContainers[0].command[2] | string | `"--"` |  |
| additionalContainers[0].envFrom[0].configMapRef.name | string | `"hpbconfig"` |  |
| additionalContainers[0].env[0].name | string | `"PORT"` |  |
| additionalContainers[0].env[0].value | string | `"7867"` |  |
| additionalContainers[0].image | string | `"nextcloud:21.0.2"` |  |
| additionalContainers[0].imagePullPolicy | string | `"IfNotPresent"` |  |
| additionalContainers[0].name | string | `"hpb"` |  |
| additionalContainers[0].ports[0].containerPort | int | `7867` |  |
| additionalContainers[0].ports[0].name | string | `"hpb"` |  |
| additionalContainers[0].securityContext.runAsGroup | int | `33` |  |
| additionalContainers[0].securityContext.runAsUser | int | `33` |  |
| additionalContainers[0].volumeMounts[0].mountPath | string | `"/var/www/html"` |  |
| additionalContainers[0].volumeMounts[0].name | string | `"data"` |  |
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
| image.repository | string | `"nextcloud"` |  |
| image.tag | string | `"22.1.1"` |  |
| initContainers[0].command[0] | string | `"sh"` |  |
| initContainers[0].command[1] | string | `"-c"` |  |
| initContainers[0].command[2] | string | `"until pg_isready -U nextcloud -h ${pghost} ; do sleep 2 ; done"` |  |
| initContainers[0].env[0].name | string | `"pghost"` |  |
| initContainers[0].env[0].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| initContainers[0].env[0].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| initContainers[0].image | string | `"postgres:13.1"` |  |
| initContainers[0].imagePullPolicy | string | `"IfNotPresent"` |  |
| initContainers[0].name | string | `"init-postgresdb"` |  |
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
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"nextcloud"` |  |
| postgresql.postgresqlUsername | string | `"nextcloud"` |  |
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
| strategy.type | string | `"Recreate"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
