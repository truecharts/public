# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| enableUpgradeBackup | bool | `false` |  |
| envTpl.POSTGRES_DB | string | `"{{ .Values.postgresqlDatabase }}"` |  |
| envTpl.POSTGRES_USER | string | `"{{ .Values.postgresqlUsername }}"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"{{ ( tpl .Values.existingSecret $ ) | default ( include \"common.names.fullname\" . ) }}"` |  |
| existingSecret | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"postgres"` |  |
| image.tag | string | `"13.4"` |  |
| persistence.db.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.db.enabled | bool | `true` |  |
| persistence.db.mountPath | string | `"/var/lib/postgresql/data"` |  |
| persistence.db.size | string | `"100Gi"` |  |
| persistence.db.type | string | `"pvc"` |  |
| persistence.dbbackups.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.dbbackups.enabled | bool | `true` |  |
| persistence.dbbackups.mountPath | string | `"/dbbackups"` |  |
| persistence.dbbackups.size | string | `"100Gi"` |  |
| persistence.dbbackups.type | string | `"pvc"` |  |
| postgresqlDatabase | string | `"test"` |  |
| postgresqlPassword | string | `"testpass"` |  |
| postgresqlUsername | string | `"test"` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `5432` |  |
| strategy.type | string | `"Recreate"` |  |

All Rights Reserved - The TrueCharts Project
