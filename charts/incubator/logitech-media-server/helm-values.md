# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
| ----| ---- | ------- | ----------- |
| image.tag | string | `latest-8.2.0` | Image tag. |
| image.pullPolicy | string | `IfNotPresent` | Image pull policy |
| env.PUID | int | `568` | The User ID the Logitech Server Application should use |
| env.PGID | int | `568` | The Group ID the Logitech Server Application should use |
| envTpl.HTTP_PORT | string | `{{ .Values.service.main.ports.main.http }}` | Port to host the web service on. This will be the internal container port exposed and needs to be the same as the node port. |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | Persistence access modes |
| persistence.config.enabled | bool | `true` | Use persistent volume to store config |
| persistence.config.mountPath | string | `"/config"` | Path inside the container for configuration data |
| persistence.config.size | string | `"100Gi"` | Size of persistent volume claim |
| persistence.config.type | string | `"pvc"` | Type of persistent volume |
| podSecurityContext.fsGroup | int | `568` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsNonRoot | bool | `false` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| service.main.ports.http.port | int | `7000` | Port used by the portal and hardware players |
| service.main.ports.cli.port | int | `9090` | Port used by the portal and hardware players |
| service.main.ports.slimprototcp.port | int | `3483` | Port used by the hardware players |
| service.playerudp.ports.slimprotoudp.port | int | `3483` | Port used by the hardware players |


All Rights Reserved - The TrueCharts Project
