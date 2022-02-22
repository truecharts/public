# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.CELLS_BIND | string | `"0.0.0.0:{{ .Values.service.main.ports.main.targetPort }}"` |  |
| env.CELLS_DATA_DIR | string | `"/cells/data"` |  |
| env.CELLS_EXTERNAL | string | `""` |  |
| env.CELLS_GRPC_EXTERNAL | string | `"{{ .Values.service.gprc.ports.gprc.targetPort }}"` |  |
| env.CELLS_HEALTHCHECK | string | `"{{ .Values.service.main.ports.main.targetPort }}"` |  |
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
| probes.liveness.path | string | `"/healthcheck"` |  |
| probes.readiness.path | string | `"/healthcheck"` |  |
| probes.startup.path | string | `"/healthcheck"` |  |
| pydioinstall.password | string | `"supersecret"` |  |
| pydioinstall.title | string | `"Pydio Cells"` |  |
| pydioinstall.username | string | `"admin"` |  |
| service.gprc.enabled | bool | `true` |  |
| service.gprc.ports.gprc.enabled | bool | `true` |  |
| service.gprc.ports.gprc.port | int | `33060` |  |
| service.gprc.ports.gprc.targetPort | int | `33060` |  |
| service.main.ports.main.port | int | `10150` |  |
| service.main.ports.main.targetPort | int | `10150` |  |

All Rights Reserved - The TrueCharts Project
