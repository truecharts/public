# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CONFIG_BACKUP_ENABLED | bool | `true` |  |
| env.INCLUDE_TUTORIALS | bool | `true` |  |
| env.MAX_NUM_THREADS | string | `"auto"` |  |
| env.NOTEBOOK_ARGS | string | `""` |  |
| env.SHARED_LINKS_ENABLED | bool | `false` |  |
| env.SHUTDOWN_INACTIVE_KERNELS | string | `"false"` |  |
| env.WORKSPACE_BASE_URL | string | `"/"` |  |
| env.WORKSPACE_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.WORKSPACE_SSL_ENABLED | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/ml-workspace"` |  |
| image.tag | string | `"0.13.2@sha256:fd0195f1d7dc85c14c554a04e7e969201fa9ed8d3448943ca235142f8b2c2ea4"` |  |
| imageGPU.pullPolicy | string | `"IfNotPresent"` |  |
| imageGPU.repository | string | `"tccr.io/truecharts/ml-workspace-gpu"` |  |
| imageGPU.tag | string | `"0.13.2@sha256:9597b92b15fd4f4f07f84c3d4a93d5905519f5323f1584391122d6ee81abac95"` |  |
| imageLight.pullPolicy | string | `"IfNotPresent"` |  |
| imageLight.repository | string | `"tccr.io/truecharts/ml-workspace-light"` |  |
| imageLight.tag | string | `"0.13.2@sha256:57258c0496b6dd2e7b7e38378cf9b00de8dc71b4ddbf2c9effb4411333b31241"` |  |
| imageMinimal.pullPolicy | string | `"IfNotPresent"` |  |
| imageMinimal.repository | string | `"tccr.io/truecharts/ml-workspace-minimal"` |  |
| imageMinimal.tag | string | `"0.13.2@sha256:e95cfd15de0777db2ae5a60752a8cdfdf449bffa23ae6cef94662018e62f9c33"` |  |
| imageSelector | string | `"image"` |  |
| persistence.shm.enabled | bool | `true` |  |
| persistence.shm.medium | string | `"Memory"` |  |
| persistence.shm.mountPath | string | `"/dev/shm"` |  |
| persistence.shm.type | string | `"emptyDir"` |  |
| persistence.workspace.enabled | bool | `true` |  |
| persistence.workspace.mountPath | string | `"/workspace"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.AUTHENTICATE_VIA_JUPYTER | string | `"mytoken"` |  |
| secret.WORKSPACE_AUTH_PASSWORD | string | `"password"` |  |
| secret.WORKSPACE_AUTH_USER | string | `"admin"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10201` |  |

All Rights Reserved - The TrueCharts Project
