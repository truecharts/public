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
| envTpl.MARIADB_DATABASE | string | `"{{ .Values.mariadbDatabase }}"` |  |
| envTpl.MARIADB_USER | string | `"{{ .Values.mariadbUsername }}"` |  |
| envValueFrom.MARIADB_PASSWORD.secretKeyRef.key | string | `"mariadb-password"` |  |
| envValueFrom.MARIADB_PASSWORD.secretKeyRef.name | string | `"{{ ( tpl .Values.existingSecret $ ) | default ( include \"common.names.fullname\" . ) }}"` |  |
| envValueFrom.MARIADB_ROOT_PASSWORD.secretKeyRef.key | string | `"mariadb-root-password"` |  |
| envValueFrom.MARIADB_ROOT_PASSWORD.secretKeyRef.name | string | `"{{ ( tpl .Values.existingSecret $ ) | default ( include \"common.names.fullname\" . ) }}"` |  |
| existingSecret | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"bitnami/mariadb"` |  |
| image.tag | string | `"10.6.5@sha256:56644d687e906ae8311afb447210cf28335b4f4a394817d45e2de5b14f271381"` |  |
| mariadbDatabase | string | `"test"` |  |
| mariadbPassword | string | `"testpass"` |  |
| mariadbRootPassword | string | `"testroot"` |  |
| mariadbUsername | string | `"test"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| probes | object | See below | Probe configuration -- [[ref]](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) |
| probes.liveness | object | See below | Liveness probe configuration |
| probes.liveness.custom | bool | `true` | Set this to `true` if you wish to specify your own livenessProbe |
| probes.liveness.enabled | bool | `true` | Enable the liveness probe |
| probes.liveness.spec | object | See below | The spec field contains the values for the default livenessProbe. If you selected `custom: true`, this field holds the definition of the livenessProbe. |
| probes.readiness | object | See below | Redainess probe configuration |
| probes.readiness.custom | bool | `true` | Set this to `true` if you wish to specify your own readinessProbe |
| probes.readiness.enabled | bool | `true` | Enable the readiness probe |
| probes.readiness.spec | object | See below | The spec field contains the values for the default readinessProbe. If you selected `custom: true`, this field holds the definition of the readinessProbe. |
| probes.startup | object | See below | Startup probe configuration |
| probes.startup.enabled | bool | `true` | Enable the startup probe |
| probes.startup.spec | object | See below | The spec field contains the values for the default livenessProbe. If you selected `custom: true`, this field holds the definition of the livenessProbe. |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `3306` |  |
| service.main.ports.main.targetPort | int | `3306` |  |
| volumeClaimTemplates.data.enabled | bool | `true` |  |
| volumeClaimTemplates.data.mountPath | string | `"/bitnami/mariadb"` |  |

All Rights Reserved - The TrueCharts Project
