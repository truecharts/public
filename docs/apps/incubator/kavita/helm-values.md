# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/kavita"` |  |
| image.tag | string | `"v0.5.1@sha256:e584e22d7382b98b0b49fbc6ec97115f82d57ca556c943268c0ced5bd567b25e"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/kavita/config"` |  |
| persistence.manga.enabled | bool | `true` |  |
| persistence.manga.mountPath | string | `"/manga"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10189` |  |
| service.main.ports.main.targetPort | int | `5000` |  |

All Rights Reserved - The TrueCharts Project
