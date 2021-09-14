# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ND_ENABLETRANSCODINGCONFIG | string | `"true"` |  |
| env.ND_LOGLEVEL | string | `"info"` |  |
| env.ND_MUSICFOLDER | string | `"/music"` |  |
| env.ND_SCANINTERVAL | string | `"15m"` |  |
| env.ND_SESSIONTIMEOUT | string | `"24h"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/truecharts/navidrome"` |  |
| image.tag | string | `"v0.45.1@sha256:2600dc55b2ac7ae31d5c3a657e731a4fde56d76903a6b6e4fb0cfc7007091a0e"` |  |
| persistence.data.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| persistence.data.size | string | `"100Gi"` |  |
| persistence.data.type | string | `"pvc"` |  |
| podSecurityContext.fsGroup | int | `568` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `568` |  |
| podSecurityContext.runAsUser | int | `568` |  |
| podSecurityContext.supplementalGroups | list | `[]` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| service.main.ports.main.port | int | `4533` |  |

All Rights Reserved - The TrueCharts Project
