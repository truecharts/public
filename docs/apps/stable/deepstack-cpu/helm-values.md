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
| image.tag | string | `"cpu-2021.02.1@sha256:db1876e7a5c73111e0cd18e26b2401c20997afdea3f8f9f9116ef951b49ba5be"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/datastore"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `5000` |  |

All Rights Reserved - The TrueCharts Project
