# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ALLOW_CHEATS | bool | `false` |  |
| env.CORRECT_PLAYER_MOVEMENT | bool | `false` |  |
| env.DEFAULT_PLAYER_PERMISSION_LEVEL | string | `"member"` |  |
| env.DIFFICULTY | string | `"easy"` |  |
| env.EULA | string | `"TRUE"` |  |
| env.GAMEMODE | string | `"survival"` |  |
| env.GID | string | `"{{ .Values.podSecurityContext.fsGroup }}"` |  |
| env.LEVEL_NAME | string | `"Bedrock level"` |  |
| env.LEVEL_SEED | string | `""` |  |
| env.LEVEL_TYPE | string | `"DEFAULT"` |  |
| env.MAX_PLAYERS | int | `10` |  |
| env.MAX_THREADS | int | `8` |  |
| env.ONLINE_MODE | bool | `true` |  |
| env.PLAYER_IDLE_TIMEOUT | int | `30` |  |
| env.PLAYER_MOVEMENT_DISTANCE_THRESHOLD | float | `0.3` |  |
| env.PLAYER_MOVEMENT_DURATION_THRESHOLD_IN_MS | int | `500` |  |
| env.PLAYER_MOVEMENT_SCORE_THRESHOLD | int | `20` |  |
| env.SERVER_AUTHORITATIVE_MOVEMENT | string | `"server-auth"` |  |
| env.SERVER_NAME | string | `"TrueCharts Dedicated Server!"` |  |
| env.SERVER_PORT | string | `"{{ .Values.service.main.ports.main.targetPort }}"` |  |
| env.SERVER_PORT_V6 | int | `19133` |  |
| env.TEXTUREPACK_REQUIRED | bool | `false` |  |
| env.TICK_DISTANCE | int | `4` |  |
| env.UID | string | `"{{ .Values.env.PUID }}"` |  |
| env.VERSION | string | `"LATEST"` |  |
| env.VIEW_DISTANCE | int | `32` |  |
| env.WHITE_LIST | bool | `false` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"tccr.io/truecharts/minecraft-bedrock"` |  |
| image.tag | string | `"2022.1.0@sha256:63fbf9347350871633418621dcf46bde8d36b647ff1c6f24555aa1487bd62698"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/data"` |  |
| probes.liveness | object | See below | Liveness probe configuration |
| probes.readiness | object | See below | Redainess probe configuration |
| probes.startup | object | See below | Startup probe configuration |
| service.main.ports.main.port | int | `19132` |  |
| service.main.ports.main.protocol | string | `"UDP"` |  |
| service.main.ports.main.targetPort | int | `19132` |  |

All Rights Reserved - The TrueCharts Project
