# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/k8s-at-home/nzbget"` |  |
| image.tag | string | `"v21.1@sha256:258c97cb99fea70b236b2f509bdb9bcad1a74658bdba441200d5e13c46c1437c"` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"100Gi"` |  |
| persistence.config.type | string | `"pvc"` |  |
| podSecurityContext.fsGroup | int | `568` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"OnRootMismatch"` |  |
| podSecurityContext.runAsGroup | int | `568` |  |
| podSecurityContext.runAsUser | int | `568` |  |
| podSecurityContext.supplementalGroups | list | `[]` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| service.main.ports.main.port | int | `6789` |  |

All Rights Reserved - The TrueCharts Project
