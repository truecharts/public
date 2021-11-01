# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.PUID | int | `568` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/linuxserver/cloud9"` |  |
| image.tag | string | `"version-1.29.2@sha256:9ab0b1812bffbc10c0c61f16c76b735472957309ebc7ff6808e28cd107e3efc7"` |  |
| persistence.code.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.code.enabled | bool | `true` |  |
| persistence.code.mountPath | string | `"/code"` |  |
| persistence.code.size | string | `"1Gi"` |  |
| persistence.sock.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.sock.enabled | bool | `true` |  |
| persistence.sock.mountPath | string | `"/var/run/docker.sock"` |  |
| persistence.sock.size | string | `"1Gi"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `8000` |  |

All Rights Reserved - The TrueCharts Project
