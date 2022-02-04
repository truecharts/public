# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.AUTOPAUSE | bool | `true` |  |
| env.AUTOSAVEINTERVAL | int | `300` |  |
| env.AUTOSAVENUM | int | `3` |  |
| env.AUTOSAVEONDISCONNECT | bool | `true` |  |
| env.CRASHREPORT | bool | `true` |  |
| env.DEBUG | bool | `false` |  |
| env.DISABLESEASONALEVENTS | bool | `false` |  |
| env.MAXPLAYERS | int | `4` |  |
| env.PUID | int | `568` |  |
| env.SERVERBEACONPORT | string | `"{{ .Values.service.beacon.ports.beacon.targetPort }}"` |  |
| env.SERVERGAMEPORT | string | `"{{ .Values.service.main.ports.main.targetPort }}"` |  |
| env.SERVERIP | string | `"0.0.0.0"` |  |
| env.SERVERQUERYPORT | string | `"{{ .Values.service.query.ports.query.targetPort }}"` |  |
| env.SKIPUPDATE | bool | `false` |  |
| env.STEAMBETA | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"wolveix/satisfactory-server"` |  |
| image.tag | string | `"v1.2.3@sha256:5860dbac9fc8cb2e6010b69e60e633d06e25e2a0152f8858a8f23acda7c3c719"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| probes.liveness | object | See below | Liveness probe configuration |
| probes.readiness | object | See below | Redainess probe configuration |
| probes.startup | object | See below | Startup probe configuration |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.beacon.enabled | bool | `true` |  |
| service.beacon.ports.beacon.enabled | bool | `true` |  |
| service.beacon.ports.beacon.port | int | `15000` |  |
| service.beacon.ports.beacon.protocol | string | `"UDP"` |  |
| service.beacon.ports.beacon.targetPort | int | `15000` |  |
| service.main.ports.main.port | int | `7777` |  |
| service.main.ports.main.protocol | string | `"UDP"` |  |
| service.main.ports.main.targetPort | int | `7777` |  |
| service.query.enabled | bool | `true` |  |
| service.query.ports.query.enabled | bool | `true` |  |
| service.query.ports.query.port | int | `15777` |  |
| service.query.ports.query.protocol | string | `"UDP"` |  |
| service.query.ports.query.targetPort | int | `15777` |  |

All Rights Reserved - The TrueCharts Project
