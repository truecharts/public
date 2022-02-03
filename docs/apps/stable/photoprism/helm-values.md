# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.HOME | string | `"/photoprism"` |  |
| env.PHOTOPRISM_CACHE_PATH | string | `"/assets/cache"` |  |
| env.PHOTOPRISM_CONFIG_PATH | string | `"/assets/config"` |  |
| env.PHOTOPRISM_DATABASE_DRIVER | string | `"mysql"` |  |
| env.PHOTOPRISM_DATABASE_NAME | string | `"photoprism"` |  |
| env.PHOTOPRISM_DATABASE_USER | string | `"photoprism"` |  |
| env.PHOTOPRISM_GID | string | `"{{ .Values.podSecurityContext.runAsGroup }}"` |  |
| env.PHOTOPRISM_IMPORT_PATH | string | `"/photoprism/import"` |  |
| env.PHOTOPRISM_ORIGINALS_PATH | string | `"/photoprism/originals"` |  |
| env.PHOTOPRISM_PUBLIC | bool | `false` |  |
| env.PHOTOPRISM_SIDECAR_PATH | string | `"/assets/sidecar"` |  |
| env.PHOTOPRISM_STORAGE_PATH | string | `"/assets/storage"` |  |
| env.PHOTOPRISM_TEMP_PATH | string | `"/photoprism/temp"` |  |
| env.PHOTOPRISM_UID | string | `"{{ .Values.podSecurityContext.runAsUser }}"` |  |
| env.PHOTOPRISM_UMASK | string | `"{{ .Values.env.UMASK }}"` |  |
| env.PROTOPRISM_BACKUP_PATH | string | `"/assets/backup"` |  |
| env.TZ | string | `"UTC"` |  |
| envValueFrom.PHOTOPRISM_DATABASE_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.PHOTOPRISM_DATABASE_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.PHOTOPRISM_DATABASE_SERVER.secretKeyRef.key | string | `"plainporthost"` |  |
| envValueFrom.PHOTOPRISM_DATABASE_SERVER.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/photoprism"` |  |
| image.tag | string | `"v20220121@sha256:ed219b601defa5d2a6e5680d5882a24181c2202852f51a07ba4cc98e80537bd6"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"photoprism"` |  |
| mariadb.mariadbUsername | string | `"photoprism"` |  |
| persistence.storage.enabled | bool | `true` |  |
| persistence.storage.mountPath | string | `"/assets"` |  |
| persistence.temp.enabled | bool | `true` |  |
| persistence.temp.mountPath | string | `"/photoprism/temp"` |  |
| persistence.temp.type | string | `"emptyDir"` |  |
| secret.PHOTOPRISM_ADMIN_PASSWORD | string | `"please-change"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `2342` |  |
| service.main.ports.main.targetPort | int | `2342` |  |

All Rights Reserved - The TrueCharts Project
