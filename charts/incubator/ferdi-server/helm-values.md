# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.APP_URL | string | `"http://localhost:3333"` |  |
| env.CONNECT_WITH_FRANZ | bool | `true` |  |
| env.DATA_DIR | string | `"/app/data"` |  |
| env.DB_CONNECTION | string | `"pg"` |  |
| env.DB_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.DB_PORT | string | `"5432"` |  |
| env.DB_SSL | bool | `false` |  |
| env.DB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.IS_CREATION_ENABLED | bool | `true` |  |
| env.IS_DASHBOARD_ENABLED | bool | `true` |  |
| env.IS_REGISTRATION_ENABLED | bool | `true` |  |
| env.NODE_ENV | string | `"production"` |  |
| envValueFrom.DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"getferdi/ferdi-server"` |  |
| image.tag | string | `"1.3.2@sha256:6e620b85afaa186f883336dc2672cc4a3a7b132eda94d160886d232d20d4335f"` |  |
| installContainers.1-create-key-file.args[0] | string | `"keyfile=\"/app/data/FERDI_APP_KEY.txt\"; if [ ! -f ${keyfile} ]; then\n  echo \"No APP_KEY File...\";\n  echo \"Creating APP_KEY file...\";\n  echo \"${APP_KEY}\" > ${keyfile};\n  if [ -f ${keyfile} ];\n  then\n    echo \"Success!\";\n  else\n    echo \"Failed.\";\n  fi;\nelse\n  echo \"APP_KEY File exists. Skipping...\";\nfi;\n"` |  |
| installContainers.1-create-key-file.command[0] | string | `"sh"` |  |
| installContainers.1-create-key-file.command[1] | string | `"-c"` |  |
| installContainers.1-create-key-file.env[0].name | string | `"APP_KEY"` |  |
| installContainers.1-create-key-file.env[0].valueFrom.secretKeyRef.key | string | `"APP_KEY"` |  |
| installContainers.1-create-key-file.env[0].valueFrom.secretKeyRef.name | string | `"ferdi-server-secrets"` |  |
| installContainers.1-create-key-file.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| installContainers.1-create-key-file.volumeMounts[0].mountPath | string | `"/app/data"` |  |
| installContainers.1-create-key-file.volumeMounts[0].name | string | `"data"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/app/data"` |  |
| persistence.recipes.enabled | bool | `true` |  |
| persistence.recipes.mountPath | string | `"/app/recipes"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"ferdi-server"` |  |
| postgresql.postgresqlUsername | string | `"ferdi-server"` |  |
| probes.liveness.path | string | `"/health"` |  |
| probes.readiness.path | string | `"/health"` |  |
| probes.startup.path | string | `"/health"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10206` |  |
| service.main.ports.main.targetPort | int | `3333` |  |

All Rights Reserved - The TrueCharts Project
