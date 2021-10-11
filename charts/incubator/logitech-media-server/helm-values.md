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
| env.SQUEEZE_UID | int | `568` | The User ID the Logitech Server Application should use |
| env.SQUEEZE_GID | int | `568` | The Group ID the Logitech Server Application should use |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | Persistence access modes |
| persistence.config.enabled | bool | `true` | Use persistent volume to store config |
| persistence.config.mountPath | string | `"/srv/squeezebox"` | Path inside the container for configuration data |
| persistence.config.size | string | `"100Gi"` | Size of persistent volume claim |
| persistence.config.type | string | `"pvc"` | Type of persistent volume |
| persistence.playlists.accessMode | string | `"ReadWriteOnce"` | Persistence access modes |
| persistence.playlists.enabled | bool | `true` | Use persistent volume to store config |
| persistence.playlists.mountPath | string | `"/playlists"` | Path inside the container for configuration data |
| persistence.playlists.size | string | `"100Gi"` | Size of persistent volume claim |
| persistence.playlists.type | string | `"hostPath"` | Type of persistent volume |
| persistence.music.accessMode | string | `"ReadWriteOnce"` | Persistence access modes |
| persistence.music.enabled | bool | `true` | Use persistent volume to store config |
| persistence.music.mountPath | string | `"/music"` | Path inside the container for configuration data |
| persistence.music.size | string | `"100Gi"` | Size of persistent volume claim |
| persistence.music.type | string | `"hostPath"` | Type of persistent volume |
| podSecurityContext.fsGroup | int | `568` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsNonRoot | bool | `false` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| service.main.ports.main.port | int | `9000` | Port used by the portal and hardware players |
| service.main.ports.main.nodePort | int | `9000` | Should be 9000 as the players expect to be able to contact the server on that port. |
| service.main.ports.main.protocol | string | `"HTTP"` |  |
| service.main.ports.cli.port | int | `9090` | Port used by the portal and hardware players |
| service.main.ports.cli.nodePort | int | `9090` | Should be 9090 as remote control apps expect to be able to connect to the server on that port using telnet to send cli commands. |
| service.main.ports.cli.protocol | string | `"TCP"` |  |
| service.commtcp.ports.playertcp.port | int | `3483` | Port used by the hardware players |
| service.commtcp.ports.playertcp.protocol | string | `"TCP"` |  |
| service.commudp.ports.playerudp.port | int | `3483` | Port used by the hardware players |
| service.commudp.ports.playerudp.protocol | string | `"UDP"` |  |


All Rights Reserved - The TrueCharts Project
