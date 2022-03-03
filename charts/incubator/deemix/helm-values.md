# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.INTPORT | string | `"{{ .Values.service.main.ports.main.targetPort }}"` |  |
| env.UMASK_SET | string | `"{{ .Values.env.UMASK }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/deemix"` |  |
| image.tag | string | `"latest@sha256:cc770caa2f11b2e1b89129e17ebbbbb2533bd3e7c93303e52a072e1b3e471f70"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/downloads"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `6595` |  |
| service.main.ports.main.targetPort | int | `6595` |  |

All Rights Reserved - The TrueCharts Project
