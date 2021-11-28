# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.MODE | string | `"High"` |  |
| env.MODELSTORE-DETECTION | string | `"/modelstore/detection"` |  |
| env.PUID | int | `568` |  |
| env.VISION-DETECTION | string | `"True"` |  |
| env.VISION-FACE | string | `"True"` |  |
| env.VISION-SCENE | string | `"True"` |  |
| envTpl.USER_ID | string | `"{{ .Values.env.PUID }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"deepquestai/deepstack"` |  |
| image.tag | string | `"gpu-2021.09.1@sha256:e71f54392c9b1199f9142d7ffcd8f0c3a6e91fe69c02a44fd76f906dd88849cb"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/datastore"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `5000` |  |
| service.main.ports.main.targetPort | int | `5000` |  |

All Rights Reserved - The TrueCharts Project
