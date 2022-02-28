# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.GRIST_DEFAULT_EMAIL | string | `"user@mydomain.com"` |  |
| env.HOME_PORT | string | `"{{ .Values.service.api.ports.api.port }}"` |  |
| env.PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"gristlabs/grist"` |  |
| image.tag | string | `"latest@sha256:c88eccaddc0cfb7744147b8059d8d54399304535b0c6d4ec332f31432cfe057e"` |  |
| persistence.persist.enabled | bool | `true` |  |
| persistence.persist.mountPath | string | `"/persist"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.api.ports.api.port | int | `10164` |  |
| service.api.ports.api.targetPort | int | `10164` |  |
| service.main.ports.main.port | int | `10163` |  |
| service.main.ports.main.targetPort | int | `10163` |  |

All Rights Reserved - The TrueCharts Project
