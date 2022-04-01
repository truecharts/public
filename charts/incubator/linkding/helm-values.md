# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.LD_DISABLE_BACKGROUND_TASKS | bool | `false` |  |
| env.LD_DISABLE_URL_VALIDATION | bool | `false` |  |
| env.LD_REQUEST_TIMEOUT | int | `60` |  |
| env.LD_SERVER_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"sissbruecker/linkding"` |  |
| image.tag | string | `"1.8.8@sha256:d8d90a253cfe2bb1087492169c8e98ad20644f079c4890bdb9a7ac874488313d"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/etc/linkding/data"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10210` |  |

All Rights Reserved - The TrueCharts Project
