# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.IPFS_PROFILE | string | `"server"` |  |
| env.IPFS_SWARM_KEY | string | `""` |  |
| env.IPFS_SWARM_KEY_FILE | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ipfs/go-ipfs"` |  |
| image.tag | string | `"v0.12.1"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data/ipfs"` |  |
| persistence.ipfs.enabled | bool | `true` |  |
| persistence.ipfs.mountPath | string | `"/ipfs"` |  |
| persistence.ipns.enabled | bool | `true` |  |
| persistence.ipns.mountPath | string | `"/ipns"` |  |
| persistence.staging.enabled | bool | `true` |  |
| persistence.staging.mountPath | string | `"/export"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| probes.liveness.path | string | `"/webui"` |  |
| probes.readiness.path | string | `"/webui"` |  |
| probes.startup.path | string | `"/webui"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.gateway.enabled | bool | `true` |  |
| service.gateway.ports.gateway.enabled | bool | `true` |  |
| service.gateway.ports.gateway.port | int | `10147` |  |
| service.gateway.ports.gateway.targetPort | int | `8080` |  |
| service.gateway.type | string | `"ClusterIP"` |  |
| service.main.ports.main.port | int | `10125` |  |
| service.main.ports.main.targetPort | int | `5001` |  |
| service.peer-tcp.enabled | bool | `true` |  |
| service.peer-tcp.ports.peer-tcp.enabled | bool | `true` |  |
| service.peer-tcp.ports.peer-tcp.port | int | `4001` |  |
| service.peer-tcp.ports.peer-tcp.targetPort | int | `4001` |  |
| service.peer-udp.enabled | bool | `true` |  |
| service.peer-udp.ports.peer-udp.enabled | bool | `true` |  |
| service.peer-udp.ports.peer-udp.port | int | `4001` |  |
| service.peer-udp.ports.peer-udp.protocol | string | `"UDP"` |  |
| service.peer-udp.ports.peer-udp.targetPort | int | `4001` |  |

All Rights Reserved - The TrueCharts Project
