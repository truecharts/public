# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.BACKUPS | bool | `true` |  |
| env.BACKUPS_DIRECTORY | string | `"/backups"` |  |
| env.BACKUPS_INTERVAL | int | `43200` |  |
| env.BACKUPS_MAX_AGE | int | `3` |  |
| env.SERVER_NAME | string | `"My Server"` |  |
| env.SERVER_PORT | string | `"{{ .Values.service.valheim.ports.valheim1.port }}"` |  |
| env.SERVER_PUBLIC | bool | `true` |  |
| env.STATUS_HTTP | bool | `true` |  |
| env.STATUS_HTTP_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.SUPERVISOR_HTTP | bool | `true` |  |
| env.SUPERVISOR_HTTP_PORT | string | `"{{ .Values.service.supervisor.ports.supervisor.port }}"` |  |
| env.TZ | string | `"UTC"` |  |
| env.UPDATE_INTERVAL | int | `10800` |  |
| env.WORLD_NAME | string | `"Dedicated"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/valheim-server"` |  |
| image.tag | string | `"latest@sha256:8f87fda54429923cac3601d581d6dc0ff273ef6438374e9f4b1e5ac1141b461d"` |  |
| persistence.backups.enabled | bool | `true` |  |
| persistence.backups.mountPath | string | `"/backups"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.SERVER_PASS | string | `"secret"` |  |
| secret.SUPERVISOR_HTTP_PASS | string | `"secret"` |  |
| secret.SUPERVISOR_HTTP_USER | string | `"admin"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `9010` |  |
| service.supervisor.enabled | bool | `true` |  |
| service.supervisor.ports.supervisor.enabled | bool | `true` |  |
| service.supervisor.ports.supervisor.port | int | `9011` |  |
| service.valheim.enabled | bool | `true` |  |
| service.valheim.ports.valheim1.enabled | bool | `true` |  |
| service.valheim.ports.valheim1.port | int | `2456` |  |
| service.valheim.ports.valheim1.protocol | string | `"UDP"` |  |
| service.valheim.ports.valheim2.enabled | bool | `true` |  |
| service.valheim.ports.valheim2.port | int | `2457` |  |
| service.valheim.ports.valheim2.protocol | string | `"UDP"` |  |
| service.valheim.ports.valheim3.enabled | bool | `true` |  |
| service.valheim.ports.valheim3.port | int | `2458` |  |
| service.valheim.ports.valheim3.protocol | string | `"UDP"` |  |
| service.valheim.type | string | `"LoadBalancer"` |  |

All Rights Reserved - The TrueCharts Project
