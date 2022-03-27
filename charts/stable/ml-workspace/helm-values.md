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
| image.repository | string | `"mltooling/ml-workspace"` |  |
| image.tag | string | `"0.13.2@sha256:5dfc8928059eb9d6d2bc33d7947e99b6bb38c2beaa40029afb73596a9c08c134"` |  |
| imageGPU.pullPolicy | string | `"IfNotPresent"` |  |
| imageGPU.repository | string | `"mltooling/ml-workspace-gpu"` |  |
| imageGPU.tag | string | `"0.13.2@sha256:ca83f64f4339344c96bb6491234008b972c1e64a1c1ef41522b8da601dfceb1e"` |  |
| imageLight.pullPolicy | string | `"IfNotPresent"` |  |
| imageLight.repository | string | `"mltooling/ml-workspace-light"` |  |
| imageLight.tag | string | `"0.13.2@sha256:cc0e1441702b49927a14d902c4530fa15ce9ad6796a61e41eaebf2e72cf77bc9"` |  |
| imageMinimal.pullPolicy | string | `"IfNotPresent"` |  |
| imageMinimal.repository | string | `"mltooling/ml-workspace-minimal"` |  |
| imageMinimal.tag | string | `"0.13.2@sha256:94206eadc4bcfd1d4af4c598f767da176ad898592b9dc54bf62ddd2d9f6d1be6"` |  |
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
