# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CELLS_BIND | string | `"0.0.0.0:{{ .Values.service.main.ports.main.port }}"` |  |
| env.CELLS_DATA_DIR | string | `"/cells/data"` |  |
| env.CELLS_EXTERNAL | string | `""` |  |
| env.CELLS_GRPC_EXTERNAL | string | `"{{ .Values.service.gprc.ports.gprc.port }}"` |  |
| env.CELLS_HEALTHCHECK | string | `"{{ .Values.service.healthcheck.ports.healthcheck.port }}"` |  |
| env.CELLS_INSTALL_YAML | string | `"/cells/install.yml"` |  |
| env.CELLS_LOG_DIR | string | `"/cells/logs"` |  |
| env.CELLS_SERVICES_DIR | string | `"/cells/services"` |  |
| env.CELLS_WORKING_DIR | string | `"/cells"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/pydio-cells"` |  |
| image.tag | string | `"v3.0.4@sha256:81c6f8675ffc243af9ffab5a43da0ed50f33f0c153c352aad027127c3c0318ad"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"pydiocells"` |  |
| mariadb.mariadbUsername | string | `"pydiocells"` |  |
| persistence.cells.enabled | bool | `true` |  |
| persistence.cells.mountPath | string | `"/cells"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/cells/data"` |  |
| persistence.logs.enabled | bool | `true` |  |
| persistence.logs.mountPath | string | `"/cells/logs"` |  |
| persistence.services.enabled | bool | `true` |  |
| persistence.services.mountPath | string | `"/cells/services"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| probes.liveness.custom | bool | `true` |  |
| probes.liveness.spec.httpGet.path | string | `"/healthcheck"` |  |
| probes.liveness.spec.httpGet.port | int | `10162` |  |
| probes.liveness.spec.httpGet.scheme | string | `"HTTP"` |  |
| probes.readiness.custom | bool | `true` |  |
| probes.readiness.spec.httpGet.path | string | `"/healthcheck"` |  |
| probes.readiness.spec.httpGet.port | int | `10162` |  |
| probes.readiness.spec.httpGet.scheme | string | `"HTTP"` |  |
| probes.startup.custom | bool | `true` |  |
| probes.startup.spec.httpGet.path | string | `"/healthcheck"` |  |
| probes.startup.spec.httpGet.port | int | `10162` |  |
| probes.startup.spec.httpGet.scheme | string | `"HTTP"` |  |
| pydioinstall.password | string | `"supersecret"` |  |
| pydioinstall.title | string | `"Pydio Cells"` |  |
| pydioinstall.username | string | `"admin"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.gprc.enabled | bool | `true` |  |
| service.gprc.ports.gprc.enabled | bool | `true` |  |
| service.gprc.ports.gprc.port | int | `33060` |  |
| service.healthcheck.enabled | bool | `true` |  |
| service.healthcheck.ports.healthcheck.enabled | bool | `true` |  |
| service.healthcheck.ports.healthcheck.port | int | `10162` |  |
| service.main.ports.main.port | int | `10150` |  |
| service.main.ports.main.protocol | string | `"HTTPS"` |  |

All Rights Reserved - The TrueCharts Project
