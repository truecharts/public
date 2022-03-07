# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CLAMAV_NO_CLAMD | bool | `false` |  |
| env.CLAMAV_NO_FRESHCLAMD | bool | `false` |  |
| env.CLAMAV_NO_MILTERD | bool | `true` |  |
| env.CLAMD_STARTUP_TIMEOUT | int | `1800` |  |
| env.FRESHCLAM_CHECKS | int | `1` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/clamav"` |  |
| image.tag | string | `"v0.104.2@sha256:eb816a62ce0b7c331d893e8d51e54fe96b1cb5878c7394e935a48468b0b44f6d"` |  |
| persistence.scandir.enabled | bool | `true` |  |
| persistence.scandir.mountPath | string | `"/scandir"` |  |
| persistence.scandir.readOnly | bool | `true` |  |
| persistence.sigdatabase.enabled | bool | `true` |  |
| persistence.sigdatabase.mountPath | string | `"/var/lib/clamav"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| probes.liveness.custom | bool | `true` |  |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.exec.command[0] | string | `"clamdcheck.sh"` |  |
| probes.liveness.spec.failureThreshold | int | `10` |  |
| probes.liveness.spec.initialDelaySeconds | int | `15` |  |
| probes.liveness.spec.periodSeconds | int | `30` |  |
| probes.liveness.spec.timeoutSeconds | int | `1` |  |
| probes.readiness.custom | bool | `true` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.exec.command[0] | string | `"clamdcheck.sh"` |  |
| probes.readiness.spec.failureThreshold | int | `10` |  |
| probes.readiness.spec.initialDelaySeconds | int | `15` |  |
| probes.readiness.spec.periodSeconds | int | `30` |  |
| probes.readiness.spec.timeoutSeconds | int | `1` |  |
| probes.startup.custom | bool | `true` |  |
| probes.startup.enabled | bool | `true` |  |
| probes.startup.spec.exec.command[0] | string | `"clamdcheck.sh"` |  |
| probes.startup.spec.failureThreshold | int | `10` |  |
| probes.startup.spec.initialDelaySeconds | int | `15` |  |
| probes.startup.spec.periodSeconds | int | `30` |  |
| probes.startup.spec.timeoutSeconds | int | `1` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `3310` |  |
| service.main.ports.main.targetPort | int | `3310` |  |
| service.milter.enabled | bool | `true` |  |
| service.milter.ports.milter.enabled | bool | `true` |  |
| service.milter.ports.milter.port | int | `7357` |  |
| service.milter.ports.milter.targetPort | int | `7357` |  |

All Rights Reserved - The TrueCharts Project
