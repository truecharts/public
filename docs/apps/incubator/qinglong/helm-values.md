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
| image.repository | string | `"tccr.io/truecharts/qinglong"` |  |
| image.tag | string | `"v2.11.3@sha256:0d0ab99a644b786d86e2d449d0840c79efaf1ad507bbc7a2cf8d7533b56f7edf"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/ql/config"` |  |
| persistence.db.enabled | bool | `true` |  |
| persistence.db.mountPath | string | `"/ql/db"` |  |
| persistence.log.enabled | bool | `true` |  |
| persistence.log.mountPath | string | `"/ql/log"` |  |
| persistence.raw.enabled | bool | `true` |  |
| persistence.raw.mountPath | string | `"/ql/raw"` |  |
| persistence.repo.enabled | bool | `true` |  |
| persistence.repo.mountPath | string | `"/ql/repo"` |  |
| persistence.scripts.enabled | bool | `true` |  |
| persistence.scripts.mountPath | string | `"/ql/scripts"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10176` |  |
| service.main.ports.main.targetPort | int | `5700` |  |

All Rights Reserved - The TrueCharts Project
