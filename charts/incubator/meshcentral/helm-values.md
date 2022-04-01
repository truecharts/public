# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ALLOWPLUGINS | bool | `false` |  |
| env.ALLOW_NEW_ACCOUNTS | bool | `true` |  |
| env.HOSTNAME | string | `"my.domain.com"` |  |
| env.IFRAME | bool | `false` |  |
| env.LOCALSESSIONRECORDING | bool | `false` |  |
| env.MINIFY | bool | `true` |  |
| env.REVERSE_PROXY | bool | `false` |  |
| env.REVERSE_PROXY_TLS_PORT | string | `""` |  |
| env.WEBRTC | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"einar/meshcentral"` |  |
| image.tag | string | `"latest@sha256:3a80bced48bdb0fa5b9043cfe51553d72ec01290f456b328c9e3921d19e472a5"` |  |
| initContainers.init.command[0] | string | `"/init/meshcentral/init.sh"` |  |
| initContainers.init.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.init.volumeMounts[0].mountPath | string | `"/init/meshcentral"` |  |
| initContainers.init.volumeMounts[0].name | string | `"init"` |  |
| mongodb.enabled | bool | `true` |  |
| mongodb.existingSecret | string | `"mongodbcreds"` |  |
| mongodb.mongodbDatabase | string | `"meshcentral"` |  |
| mongodb.mongodbUsername | string | `"meshcentral"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/opt/meshcentral/meshcentral-data"` |  |
| persistence.init.enabled | string | `"true"` |  |
| persistence.init.mountPath | string | `"/init/meshcentral"` |  |
| persistence.init.noMount | bool | `true` |  |
| persistence.init.readOnly | bool | `true` |  |
| persistence.init.type | string | `"custom"` |  |
| persistence.init.volumeSpec.configMap.defaultMode | int | `511` |  |
| persistence.init.volumeSpec.configMap.name | string | `"meshcentral-init"` |  |
| persistence.user.enabled | bool | `true` |  |
| persistence.user.mountPath | string | `"/opt/meshcentral/meshcentral-files"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10205` |  |
| service.main.ports.main.protocol | string | `"HTTPS"` |  |
| service.main.ports.main.targetPort | int | `443` |  |

All Rights Reserved - The TrueCharts Project
