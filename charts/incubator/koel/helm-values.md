# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DB_CONNECTION | string | `"mysql"` |  |
| env.DB_DATABASE | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.DB_PORT | string | `"3306"` |  |
| env.DB_USERNAME | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.FORCE_HTTPS | bool | `false` |  |
| env.LASTFM_API_KEY | string | `""` |  |
| env.LASTFM_API_SECRET | string | `""` |  |
| env.MEMORY_LIMIT | int | `2048` |  |
| env.YOUTUBE_API_KEY | string | `""` |  |
| envValueFrom.APP_KEY.secretKeyRef.key | string | `"APP_KEY"` |  |
| envValueFrom.APP_KEY.secretKeyRef.name | string | `"koel-secrets"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/koel"` |  |
| image.tag | string | `"latest@sha256:4fdc640e5b7d3fd6dd32e61f70bd9d9ac9f59b43d553064a19453b04de0251f1"` |  |
| installContainers.initdb.command[0] | string | `"php"` |  |
| installContainers.initdb.command[1] | string | `"artisan"` |  |
| installContainers.initdb.command[2] | string | `"koel:init"` |  |
| installContainers.initdb.command[3] | string | `"--no-assets"` |  |
| installContainers.initdb.env[0].name | string | `"DB_CONNECTION"` |  |
| installContainers.initdb.env[0].value | string | `"mysql"` |  |
| installContainers.initdb.env[1].name | string | `"DB_PORT"` |  |
| installContainers.initdb.env[1].value | string | `"3306"` |  |
| installContainers.initdb.env[2].name | string | `"DB_USERNAME"` |  |
| installContainers.initdb.env[2].value | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| installContainers.initdb.env[3].name | string | `"DB_DATABASE"` |  |
| installContainers.initdb.env[3].value | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| installContainers.initdb.env[4].name | string | `"DB_HOST"` |  |
| installContainers.initdb.env[4].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| installContainers.initdb.env[4].valueFrom.secretKeyRef.name | string | `"mariadbcreds"` |  |
| installContainers.initdb.env[5].name | string | `"DB_PASSWORD"` |  |
| installContainers.initdb.env[5].valueFrom.secretKeyRef.key | string | `"mariadb-password"` |  |
| installContainers.initdb.env[5].valueFrom.secretKeyRef.name | string | `"mariadbcreds"` |  |
| installContainers.initdb.env[6].name | string | `"APP_KEY"` |  |
| installContainers.initdb.env[6].valueFrom.secretKeyRef.key | string | `"APP_KEY"` |  |
| installContainers.initdb.env[6].valueFrom.secretKeyRef.name | string | `"koel-secrets"` |  |
| installContainers.initdb.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| installContainers.initdb.volumeMounts[0].mountPath | string | `"/music"` |  |
| installContainers.initdb.volumeMounts[0].name | string | `"music"` |  |
| installContainers.initdb.volumeMounts[1].mountPath | string | `"/var/www/html/public/img/covers"` |  |
| installContainers.initdb.volumeMounts[1].name | string | `"covers"` |  |
| installContainers.initdb.volumeMounts[2].mountPath | string | `"/var/www/html/storage/search-indexes"` |  |
| installContainers.initdb.volumeMounts[2].name | string | `"searchindex"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"koel"` |  |
| mariadb.mariadbUsername | string | `"koel"` |  |
| persistence.covers.enabled | bool | `true` |  |
| persistence.covers.mountPath | string | `"/var/www/html/public/img/covers"` |  |
| persistence.music.enabled | bool | `true` |  |
| persistence.music.mountPath | string | `"/music"` |  |
| persistence.searchindex.enabled | bool | `true` |  |
| persistence.searchindex.mountPath | string | `"/var/www/html/storage/search-indexes"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10185` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
