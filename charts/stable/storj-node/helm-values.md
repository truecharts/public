# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ADDRESS | string | `""` |  |
| env.EMAIL | string | `""` |  |
| env.SETUP | bool | `true` |  |
| env.STORAGE | string | `"500GB"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"storjlabs/storagenode"` |  |
| image.tag | string | `"6e7a89161-v1.49.5-go1.17.5@sha256:62f5c05ffabb0fe5d2e0c556a91c08fe6b47ff20df95f350739fa8c07f628877"` |  |
| persistence.identity.enabled | bool | `true` |  |
| persistence.identity.mountPath | string | `"/app/identity"` |  |
| persistence.storage.enabled | bool | `true` |  |
| persistence.storage.mountPath | string | `"/app/config"` |  |
| secret.WALLET | string | `"walletaddress"` |  |
| service.coretcp.enabled | bool | `true` |  |
| service.coretcp.ports.coretcp.enabled | bool | `true` |  |
| service.coretcp.ports.coretcp.port | int | `28967` |  |
| service.coretcp.ports.coretcp.protocol | string | `"TCP"` |  |
| service.coretcp.ports.coretcp.targetPort | int | `28967` |  |
| service.coreudp.enabled | bool | `true` |  |
| service.coreudp.ports.coreudp.enabled | bool | `true` |  |
| service.coreudp.ports.coreudp.port | int | `28967` |  |
| service.coreudp.ports.coreudp.protocol | string | `"UDP"` |  |
| service.coreudp.ports.coreudp.targetPort | int | `28967` |  |
| service.main.ports.main.port | int | `14002` |  |
| service.main.ports.main.targetPort | int | `14002` |  |

All Rights Reserved - The TrueCharts Project
