# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DB_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.JAVA_OPTS | string | `""` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"xwiki"` |  |
| image.tag | string | `"14.2.1-postgres-tomcat@sha256:506e2e0d7c46265df1f054960c1957acd92f262ba4a97dc539b1d6ed5a5557ba"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/usr/local/xwiki"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"xwiki"` |  |
| postgresql.postgresqlUsername | string | `"xwiki"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10208` |  |
| service.main.ports.main.targetPort | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
