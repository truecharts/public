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
| envValueFrom.POSTGRESQL_POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-postgres-password"` |  |
| envValueFrom.POSTGRESQL_POSTGRES_PASSWORD.secretKeyRef.name | string | `"{{ ( tpl .Values.existingSecret $ ) | default ( include \"common.names.fullname\" . ) }}"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"{{ ( tpl .Values.existingSecret $ ) | default ( include \"common.names.fullname\" . ) }}"` |  |
| existingSecret | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"bitnami/postgresql"` |  |
| image.tag | string | `"14.0.0@sha256:a95e5588c9f716bfc716b090f3cea41cbefb0d2c6e1c3c6de5514a5c2d1ce416"` |  |
| persistence.db.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.db.enabled | bool | `true` |  |
| persistence.db.mountPath | string | `"/bitnami/postgresql"` |  |
| persistence.db.size | string | `"999Gi"` |  |
| persistence.db.type | string | `"pvc"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| postgrespassword | string | `"testroot"` |  |
| postgresqlDatabase | string | `"test"` |  |
| postgresqlPassword | string | `"testpass"` |  |
| postgresqlUsername | string | `"test"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `5432` |  |
| service.main.ports.main.targetPort | int | `5432` |  |
| service.type | string | `"ClusterIP"` |  |

All Rights Reserved - The TrueCharts Project
