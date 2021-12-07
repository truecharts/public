# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://docs.photoprism.org/getting-started/config-options/) for more details. |
| env.GID | string | `nil` | Sets GID Photoprism runs under. |
| env.PHOTOPRISM_ADMIN_PASSWORD | string | `"please-change"` | Initial admin password. **BE SURE TO CHANGE THIS!** |
| env.PHOTOPRISM_CACHE_PATH | string | `"/assets/cache"` | Photoprism cache path |
| env.PHOTOPRISM_CONFIG_PATH | string | `"/assets/config"` | Photoprism config path |
| env.PHOTOPRISM_IMPORT_PATH | string | `"/photoprism/import"` | Photoprism import path |
| env.PHOTOPRISM_ORIGINALS_PATH | string | `"/photoprism/originals"` | Photoprism originals path |
| env.PHOTOPRISM_PUBLIC | string | `"false"` | Disable authentication / password protection |
| env.PHOTOPRISM_SIDECAR_PATH | string | `"/assets/sidecar"` | Photoprism sidecar path |
| env.PHOTOPRISM_STORAGE_PATH | string | `"/assets/storage"` | Photoprism storage path |
| env.PHOTOPRISM_TEMP_PATH | string | `"/photoprism/temp"` | Photoprism temp path |
| env.PROTOPRISM_BACKUP_PATH | string | `"/assets/backup"` | Photoprism backup path |
| env.TZ | string | `"UTC"` | Set the container timezone |
| env.UID | string | `nil` | Sets UID Photoprism runs under. |
| env.UMASK | string | `nil` | Sets UMASK. |
| envValueFrom.PHOTOPRISM_DATABASE_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.PHOTOPRISM_DATABASE_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.PHOTOPRISM_DATABASE_SERVER.secretKeyRef.key | string | `"plainporthost"` |  |
| envValueFrom.PHOTOPRISM_DATABASE_SERVER.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"tccr.io/truecharts/photoprism"` | image repository |
| image.tag | string | `"v20211203@sha256:a1455179da40abe39c1a8750e9f9b8134d3bfb506a0e642dcd5fc3b69579b571"` | image tag |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"photoprism"` |  |
| mariadb.mariadbUsername | string | `"photoprism"` |  |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
