# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DB_BASE | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| env.DB_PORT | string | `"3306"` |  |
| env.DB_TYPE | string | `"mysql"` |  |
| env.DB_USER | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| env.TRUSTED_HOSTS | string | `"172.16.0.0/12"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"mariadbcreds"` |  |
| envValueFrom.DB_PASS.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.DB_PASS.secretKeyRef.name | string | `"mariadbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"kimai/kimai2"` |  |
| image.tag | string | `"apache-1.19-prod@sha256:e4a92b3a87c782a8ad75fcb8468c654232ea8043efe5409877e1b06c7562f95b"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"kimai"` |  |
| mariadb.mariadbUsername | string | `"kimai"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/opt/kimai/public"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.ADMINMAIL | string | `"admin@mysecretdomain.com"` |  |
| secret.ADMINPASS | string | `"MvvTfjagiaqDprGNVA"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10198` |  |
| service.main.ports.main.targetPort | int | `8001` |  |

All Rights Reserved - The TrueCharts Project
