# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ACCOUNTS_DEMO_USERS_AND_GROUPS | bool | `false` |  |
| env.OCIS_INSECURE | bool | `true` |  |
| env.OCIS_LOG_COLOR | bool | `true` |  |
| env.OCIS_LOG_PRETTY | bool | `true` |  |
| env.OCIS_URL | string | `"https://localhost:{{ .Values.service.main.ports.main.port }}"` |  |
| env.PROXY_HTTP_ADDR | string | `"0.0.0.0:{{ .Values.service.main.ports.main.port }}"` |  |
| env.PROXY_TLS | bool | `false` |  |
| envValueFrom.OCIS_JWT_SECRET.secretKeyRef.key | string | `"OCIS_JWT_SECRET"` |  |
| envValueFrom.OCIS_JWT_SECRET.secretKeyRef.name | string | `"ocis-secrets"` |  |
| envValueFrom.OCIS_MACHINE_AUTH_API_KEY.secretKeyRef.key | string | `"OCIS_MACHINE_AUTH_API_KEY"` |  |
| envValueFrom.OCIS_MACHINE_AUTH_API_KEY.secretKeyRef.name | string | `"ocis-secrets"` |  |
| envValueFrom.STORAGE_TRANSFER_SECRET.secretKeyRef.key | string | `"STORAGE_TRANSFER_SECRET"` |  |
| envValueFrom.STORAGE_TRANSFER_SECRET.secretKeyRef.name | string | `"ocis-secrets"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/ocis"` |  |
| image.tag | string | `"v1.17.0@sha256:3721e88225a3caa157c3308cc630a3adf4ebc546a1786b9e28bf66b8fb2c3a64"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/var/lib/ocis"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `9200` |  |
| service.main.ports.main.protocol | string | `"HTTPS"` |  |
| service.main.ports.main.targetPort | int | `9200` |  |

All Rights Reserved - The TrueCharts Project
