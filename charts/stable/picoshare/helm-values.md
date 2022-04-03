# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| envValueFrom.PS_SHARED_SECRET.secretKeyRef.key | string | `"PS_SHARED_SECRET"` |  |
| envValueFrom.PS_SHARED_SECRET.secretKeyRef.name | string | `"picoshare-secrets"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/picoshare"` |  |
| image.tag | string | `"v1.0.5@sha256:abccdd7d31a61788859b926a9eacbcd18494e996269f03dc4ff32d07f0b6a576"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| secret.LITESTREAM_ACCESS_KEY_ID | string | `""` |  |
| secret.LITESTREAM_BUCKET | string | `""` |  |
| secret.LITESTREAM_ENDPOINT | string | `""` |  |
| secret.LITESTREAM_SECRET_ACCESS_KEY | string | `""` |  |
| service.main.ports.main.port | int | `10209` |  |

All Rights Reserved - The TrueCharts Project
