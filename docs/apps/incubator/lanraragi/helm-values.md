# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.LRR_GID | string | `"{{ .Values.podSecurityContext.fsGroup }}"` |  |
| env.LRR_UID | string | `"{{ .Values.security.PUID }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"difegue/lanraragi"` |  |
| image.tag | string | `"v.0.8.4@sha256:f059a0bffbb3f5c6aae001388e4317f4ff78ca7b1f905ee65b27a1f3a894ccef"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/home/koyomi/lanraragi/database"` |  |
| persistence.content.enabled | bool | `true` |  |
| persistence.content.mountPath | string | `"/home/koyomi/lanraragi/content"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10177` |  |
| service.main.ports.main.targetPort | int | `3000` |  |

All Rights Reserved - The TrueCharts Project
