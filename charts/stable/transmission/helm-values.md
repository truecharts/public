# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | `{"TRANSMISSION_PEER_PORT":"{{ .Values.service.torrent.ports.torrent.targetPort }}","TRANSMISSION_RPC_PORT":"{{ .Values.service.main.ports.main.targetPort }}"}` |  TRANSMISSION_RPC_PASSWORD: "" |
| env.TRANSMISSION_PEER_PORT | string | `"{{ .Values.service.torrent.ports.torrent.targetPort }}"` |  TRANSMISSION_ALT_SPEED_DOWN: 50 TRANSMISSION_ALT_SPEED_ENABLED: false TRANSMISSION_ALT_SPEED_TIME_BEGIN: 540 TRANSMISSION_ALT_SPEED_TIME_DAY: 127 TRANSMISSION_ALT_SPEED_TIME_ENABLED: false TRANSMISSION_ALT_SPEED_TIME_END: 1020 TRANSMISSION_ALT_SPEED_UP: 50 TRANSMISSION_BIND_ADDRESS_IPV4: "0.0.0.0" TRANSMISSION_BIND_ADDRESS_IPV6: "::" TRANSMISSION_BLOCKLIST_ENABLED: true TRANSMISSION_BLOCKLIST_URL: "http://john.bitsurge.net/public/biglist.p2p.gz" TRANSMISSION_CACHE_SIZE_MB: 4 TRANSMISSION_DHT_ENABLED: true TRANSMISSION_DOWNLOAD_DIR: "/downloads/complete" TRANSMISSION_DOWNLOAD_QUEUE_ENABLED: true TRANSMISSION_DOWNLOAD_QUEUE_SIZE: 5 TRANSMISSION_ENCRYPTION: 1 TRANSMISSION_IDLE_SEEDING_LIMIT: 30 TRANSMISSION_IDLE_SEEDING_LIMIT_ENABLED: false TRANSMISSION_INCOMPLETE_DIR: "/downloads/incomplete" TRANSMISSION_INCOMPLETE_DIR_ENABLED: true TRANSMISSION_LPD_ENABLED: false TRANSMISSION_MESSAGE_LEVEL: 2 TRANSMISSION_PEER_CONGESTION_ALGORITHM: "" TRANSMISSION_PEER_ID_TTL_HOURS: 6 TRANSMISSION_PEER_LIMIT_GLOBAL: 200 TRANSMISSION_PEER_LIMIT_PER_TORRENT: 50 |
| env.TRANSMISSION_RPC_PORT | string | `"{{ .Values.service.main.ports.main.targetPort }}"` |  TRANSMISSION_PEER_PORT_RANDOM_LOW: 49152 TRANSMISSION_PEER_PORT_RANDOM_ON_START: false TRANSMISSION_PEER_SOCKET_TOS: default" TRANSMISSION_PEX_ENABLED: true TRANSMISSION_PORT_FORWARDING_ENABLED: false TRANSMISSION_PREALLOCATION: 1 TRANSMISSION_PREFETCH_ENABLED: true TRANSMISSION_QUEUE_STALLED_ENABLED: true TRANSMISSION_QUEUE_STALLED_MINUTES: 30 TRANSMISSION_RATIO_LIMIT: 2 TRANSMISSION_RATIO_LIMIT_ENABLED: false TRANSMISSION_RENAME_PARTIAL_FILES: true TRANSMISSION_RPC_AUTHENTICATION_REQUIRED: false TRANSMISSION_RPC_BIND_ADDRESS: "0.0.0.0" TRANSMISSION_RPC_ENABLED: true TRANSMISSION_RPC_HOST_WHITELIST: "" TRANSMISSION_RPC_HOST_WHITELIST_ENABLED: false |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/transmission"` |  |
| image.tag | string | `"v3.00@sha256:06b6839f7401357797e8aca435e58c87407c6006d74e92b88b10c51855ff0c94"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| secret | object | `{}` |  |
| service.main.ports.main.port | int | `10109` |  |
| service.main.ports.main.targetPort | int | `9091` |  |
| service.torrent.enabled | bool | `true` |  |
| service.torrent.ports.torrent.enabled | bool | `true` |  |
| service.torrent.ports.torrent.port | int | `51414` |  |
| service.torrent.ports.torrent.targetPort | int | `51414` |  |
| service.torrentudp.enabled | bool | `true` |  |
| service.torrentudp.ports.torrentudp.enabled | bool | `true` |  |
| service.torrentudp.ports.torrentudp.port | int | `51414` |  |
| service.torrentudp.ports.torrentudp.protocol | string | `"UDP"` |  |
| service.torrentudp.ports.torrentudp.targetPort | int | `51414` |  |

All Rights Reserved - The TrueCharts Project
