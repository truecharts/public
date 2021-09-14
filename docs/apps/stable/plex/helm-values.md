# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ALLOWED_NETWORKS | string | `"172.16.0.0/16"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/k8s-at-home/plex"` |  |
| image.tag | string | `"v1.24.2.4973-2b1b51db9@sha256:1f95a305586ca958c5a137f83ebc29cd2e110fcc37f1b6a4ca80f263bc518aaa"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| podSecurityContext.fsGroup | int | `568` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `568` |  |
| podSecurityContext.runAsUser | int | `568` |  |
| podSecurityContext.supplementalGroups[0] | int | `44` |  |
| podSecurityContext.supplementalGroups[1] | int | `107` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| service.main.ports.main.port | int | `32400` |  |

All Rights Reserved - The TrueCharts Project
