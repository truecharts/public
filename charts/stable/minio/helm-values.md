# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| args | list | `["server","/data","--console-address",":9001"]` | Override the args for the default container. |
| env | object | See below | environment variables. See more environment variables in the [minio documentation](https://docs.min.io). |
| env.MINIO_ROOT_USER | string | `"minio"` | Minio Username |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"minio/minio"` | image repository |
| image.tag | string | `"RELEASE.2021-11-05T09-16-26Z@sha256:a11692068c588e7ea895f76d619a5fcb30eefc8a759e2ad7d6ec92331e43386e"` | image tag |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/data"` |  |
| probes.liveness.path | string | `"/minio/health/live"` |  |
| probes.readiness.path | string | `"/minio/health/ready"` |  |
| secret.MINIO_ROOT_PASSWORD | string | `"changeme"` | Minio Password |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
