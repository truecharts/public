# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.PUID | int | `568` |  |
| envTpl.SHIORI_PG_NAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| envTpl.SHIORI_PG_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envValueFrom.SHIORI_PG_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.SHIORI_PG_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.SHIORI_PG_PASS.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.SHIORI_PG_PASS.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/nicholaswilde/shiori"` |  |
| image.tag | string | `"version-v1.5.0@sha256:399e73a1c5a99bd2ccd46314918b6f189ec865405a09219fe99b5663ab4c1dbe"` |  |
| persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| persistence.data.size | string | `"1Gi"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"shiori"` |  |
| postgresql.postgresqlUsername | string | `"shiori"` |  |
| secret | object | `{}` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `8080` |  |

All Rights Reserved - The TrueCharts Project
