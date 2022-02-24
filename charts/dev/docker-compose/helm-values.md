# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controller.replicas | int | `1` | Number of desired pods |
| controller.revisionHistoryLimit | int | `3` | ReplicaSet revision history limit |
| controller.rollingUpdate.partition | string | `nil` | Set statefulset RollingUpdate partition |
| controller.rollingUpdate.surge | string | `nil` | Set deployment RollingUpdate max surge |
| controller.rollingUpdate.unavailable | int | `1` | Set deployment RollingUpdate max unavailable |
| controller.strategy | string | `"RollingUpdate"` | Set the controller upgrade strategy For Deployments, valid values are Recreate (default) and RollingUpdate. For StatefulSets, valid values are OnDelete and RollingUpdate (default). DaemonSets ignore this. |
| controller.type | string | `"statefulset"` | Set the controller type. Valid options are deployment, daemonset or statefulset |
| env.DOCKER_TLS_CERTDIR | string | `"/certs"` |  |
| hostNetwork | bool | `true` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/docker-in-docker"` |  |
| image.tag | string | `"v20.10.12@sha256:e672e85d8141beffea3f7e5b97c79a2bca726bde478474e845fc338a08a1092f"` |  |
| persistence.docker-certs-ca.enabled | bool | `true` |  |
| persistence.docker-certs-ca.mountPath | string | `"/config"` |  |
| persistence.mnt.enabled | bool | `true` |  |
| persistence.mnt.hostPath | string | `"/mnt"` |  |
| persistence.mnt.hostPathType | string | `""` |  |
| persistence.mnt.mountPath | string | `"/mnt"` |  |
| persistence.mnt.readOnly | bool | `false` |  |
| persistence.mnt.type | string | `"hostPath"` |  |
| persistence.root.enabled | bool | `true` |  |
| persistence.root.hostPath | string | `"/root"` |  |
| persistence.root.hostPathType | string | `""` |  |
| persistence.root.mountPath | string | `"/root"` |  |
| persistence.root.readOnly | bool | `false` |  |
| persistence.root.type | string | `"hostPath"` |  |
| persistence.varrun.enabled | bool | `false` |  |
| podSecurityContext.fsGroup | int | `0` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.allowPrivilegeEscalation | bool | `true` |  |
| securityContext.privileged | bool | `true` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.enabled | bool | `true` |  |
| service.main.ports.main.port | int | `2376` |  |
| service.main.ports.main.type | string | `"HTTPS"` |  |
| volumeClaimTemplates.docker-certs-client.enabled | bool | `true` |  |
| volumeClaimTemplates.docker-certs-client.mountPath | string | `"/certs/client"` |  |
| volumeClaimTemplates.docker.enabled | bool | `true` |  |
| volumeClaimTemplates.docker.mountPath | string | `"/var/lib/docker"` |  |

All Rights Reserved - The TrueCharts Project
