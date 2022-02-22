# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| args[0] | string | `"server"` |  |
| args[1] | string | `"/data"` |  |
| args[2] | string | `"--address"` |  |
| args[3] | string | `":10106"` |  |
| args[4] | string | `"--console-address"` |  |
| args[5] | string | `":10107"` |  |
| env.MINIO_BROWSER_REDIRECT_URL | string | `""` |  |
| env.MINIO_ROOT_USER | string | `"minio"` |  |
| env.MINIO_SERVER_URL | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/minio"` |  |
| image.tag | string | `"latest@sha256:8129f69c85b84e13f085a1ce127f108cee0ea84a1f496e8065796c7a15a08442"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/data"` |  |
| probes.liveness.custom | bool | `true` |  |
| probes.liveness.spec.httpGet.path | string | `"/minio/health/live"` |  |
| probes.liveness.spec.httpGet.port | int | `10106` |  |
| probes.liveness.spec.httpGet.scheme | string | `"HTTP"` |  |
| probes.readiness.custom | bool | `true` |  |
| probes.readiness.spec.httpGet.path | string | `"/minio/health/ready"` |  |
| probes.readiness.spec.httpGet.port | int | `10106` |  |
| probes.readiness.spec.httpGet.scheme | string | `"HTTP"` |  |
| secret.MINIO_ROOT_PASSWORD | string | `"changeme"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.api.enabled | bool | `true` |  |
| service.api.ports.api.enabled | bool | `true` |  |
| service.api.ports.api.port | int | `10106` |  |
| service.api.ports.api.targetPort | int | `10106` |  |
| service.main.ports.main.port | int | `10107` |  |
| service.main.ports.main.targetPort | int | `10107` |  |

All Rights Reserved - The TrueCharts Project
