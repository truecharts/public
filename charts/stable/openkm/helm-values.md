# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See more environment variables in the [openkm documentation](https://openkm.org/docs). |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"openkm/openkm-ce"` | image repository |
| image.tag | string | `"6.3.11@sha256:15bf6110539b02795a52f4472d95511736cfbdedef8396baf24c65a3aae28814"` | image tag |
| initContainers.init.command[0] | string | `"/config/init/init.sh"` |  |
| initContainers.init.image | string | `"{{ .Values.alpineImage.repository }}:{{ .Values.alpineImage.tag }}"` |  |
| initContainers.init.volumeMounts[0].mountPath | string | `"/config/init"` |  |
| initContainers.init.volumeMounts[0].name | string | `"init"` |  |
| initContainers.init.volumeMounts[1].mountPath | string | `"/opt/tomcat"` |  |
| initContainers.init.volumeMounts[1].name | string | `"config"` |  |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"openkm"` |  |
| postgresql.postgresqlUsername | string | `"openkm"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
