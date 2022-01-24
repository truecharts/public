# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| configmap.deepstack.data.VISION-DETECTION | string | `"{{ ternary \"True\" \"False\" .Values.deepstack.vision_detection }}"` |  |
| configmap.deepstack.data.VISION-ENHANCE | string | `"{{ ternary \"True\" \"False\" .Values.deepstack.vision_enhance }}"` |  |
| configmap.deepstack.data.VISION-FACE | string | `"{{ ternary \"True\" \"False\" .Values.deepstack.vision_face }}"` |  |
| configmap.deepstack.data.VISION-SCENE | string | `"{{ ternary \"True\" \"False\" .Values.deepstack.vision_scene }}"` |  |
| configmap.deepstack.enabled | bool | `true` |  |
| deepstack.vision_detection | bool | `true` |  |
| deepstack.vision_enhance | bool | `true` |  |
| deepstack.vision_face | bool | `true` |  |
| deepstack.vision_scene | bool | `true` |  |
| env.MODE | string | `"High"` |  |
| env.MODELSTORE-DETECTION | string | `"{{ .Values.persistence.modelstore.mountPath }}"` |  |
| env.PUID | int | `568` |  |
| env.USER_ID | string | `"{{ .Values.env.PUID }}"` |  |
| envFrom[0].configMapRef.name | string | `"{{ include \"common.names.fullname\" . }}-deepstack"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/deepstack-cpu"` |  |
| image.tag | string | `"v2021.09.1@sha256:f924cebf518a54bca2ca2ac33911cf3af4dd7403cad371781422436ce4254a28"` |  |
| imageGPU.pullPolicy | string | `"IfNotPresent"` |  |
| imageGPU.repository | string | `"tccr.io/truecharts/deepstack-gpu"` |  |
| imageGPU.tag | string | `"v2021.09.1@sha256:f924cebf518a54bca2ca2ac33911cf3af4dd7403cad371781422436ce4254a28"` |  |
| imageSelector | string | `"image"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/datastore"` |  |
| persistence.modelstore.enabled | bool | `true` |  |
| persistence.modelstore.mountPath | string | `"/modelstore/detection"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.ADMIN-KEY | string | `""` |  |
| secret.API-KEY | string | `""` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10049` |  |
| service.main.ports.main.targetPort | int | `5000` |  |

All Rights Reserved - The TrueCharts Project
