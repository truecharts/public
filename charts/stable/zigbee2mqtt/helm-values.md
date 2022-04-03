# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.USE_CUSTOM_CONFIG_FILE | bool | `false` |  |
| env.ZIGBEE2MQTT_CONFIG_FRONTEND_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.ZIGBEE2MQTT_DATA | string | `"/data"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/zigbee2mqtt"` |  |
| image.tag | string | `"v1.24.0@sha256:2574cbd6af36d0305c8034804e2c64f672757133d71b14f87f36913a9b97e754"` |  |
| initContainers.init-config.args[0] | string | `"if [ -f /data/configuration.yaml ] || [ ${USE_CUSTOM_CONFIG_FILE} == true ]; then\n  echo \"Initial configuration exists or User selected to use custom configuration file. Skipping...\";\nelse\n  echo \"Creating initial configuration\";\n  touch /data/configuration.yaml;\n  echo \"# Configuration bellow will be always be overridden\" >> /data/configuration.yaml;\n  echo \"# from environment settings on the Scale Apps UI.\" >> /data/configuration.yaml;\n  echo \"# You however will not see this values change in the file.\" >> /data/configuration.yaml;\n  echo \"# It's a generated file based on the values provided on initial install.\" >> /data/configuration.yaml;\n  echo \"##########################################################\" >> /data/configuration.yaml;\n  echo \"experimental:\" >> /data/configuration.yaml;\n  echo \"  new_api: $ZIGBEE2MQTT_CONFIG_EXPIRIMENTAL_NEW_API\" >> /data/configuration.yaml;\n  echo \"frontend:\" >> /data/configuration.yaml;\n  echo \"  port: $ZIGBEE2MQTT_CONFIG_FRONTEND_PORT\" >> /data/configuration.yaml;\n  echo \"permit_join: $ZIGBEE2MQTT_CONFIG_PERMIT_JOIN\" >> /data/configuration.yaml;\n  echo \"mqtt:\" >> /data/configuration.yaml;\n  echo \"  server: $ZIGBEE2MQTT_CONFIG_MQTT_SERVER\" >> /data/configuration.yaml;\n  echo \"  base_topic: $ZIGBEE2MQTT_CONFIG_MQTT_BASE_TOPIC\" >> /data/configuration.yaml;\n  if [ ! -z \"$ZIGBEE2MQTT_CONFIG_MQTT_USER\" ];\n  then\n    echo \"  user: $ZIGBEE2MQTT_CONFIG_MQTT_USER\" >> /data/configuration.yaml;\n  fi;\n  if [ ! -z \"$ZIGBEE2MQTT_CONFIG_MQTT_PASSWORD\" ];\n  then\n    echo \"  password: $ZIGBEE2MQTT_CONFIG_MQTT_PASSWORD\" >> /data/configuration.yaml;\n  fi;\n  echo \"serial:\" >> /data/configuration.yaml;\n  echo \"  port: $ZIGBEE2MQTT_CONFIG_SERIAL_PORT\" >> /data/configuration.yaml;\n  echo \"  adapter: $ZIGBEE2MQTT_CONFIG_SERIAL_ADAPTER\" >> /data/configuration.yaml;\n  echo \"##########################################################\" >> /data/configuration.yaml;\n  echo 'Initial configuration file created at \"/data/configuration.yaml\"';\nfi;\n"` |  |
| initContainers.init-config.command[0] | string | `"/bin/sh"` |  |
| initContainers.init-config.command[1] | string | `"-c"` |  |
| initContainers.init-config.env[0].name | string | `"ZIGBEE2MQTT_CONFIG_FRONTEND_PORT"` |  |
| initContainers.init-config.env[0].value | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| initContainers.init-config.env[10].name | string | `"USE_CUSTOM_CONFIG_FILE"` |  |
| initContainers.init-config.env[10].value | string | `"{{ .Values.env.USE_CUSTOM_CONFIG_FILE }}"` |  |
| initContainers.init-config.env[1].name | string | `"ZIGBEE2MQTT_CONFIG_EXPIRIMENTAL_NEW_API"` |  |
| initContainers.init-config.env[1].value | string | `"{{ .Values.env.ZIGBEE2MQTT_CONFIG_EXPIRIMENTAL_NEW_API }}"` |  |
| initContainers.init-config.env[2].name | string | `"ZIGBEE2MQTT_CONFIG_PERMIT_JOIN"` |  |
| initContainers.init-config.env[2].value | string | `"{{ .Values.env.ZIGBEE2MQTT_CONFIG_PERMIT_JOIN }}"` |  |
| initContainers.init-config.env[3].name | string | `"ZIGBEE2MQTT_CONFIG_EXPIRIMENTAL_NEW_API"` |  |
| initContainers.init-config.env[3].value | string | `"{{ .Values.env.ZIGBEE2MQTT_CONFIG_EXPIRIMENTAL_NEW_API }}"` |  |
| initContainers.init-config.env[4].name | string | `"ZIGBEE2MQTT_CONFIG_MQTT_SERVER"` |  |
| initContainers.init-config.env[4].value | string | `"{{ .Values.env.ZIGBEE2MQTT_CONFIG_MQTT_SERVER }}"` |  |
| initContainers.init-config.env[5].name | string | `"ZIGBEE2MQTT_CONFIG_MQTT_USER"` |  |
| initContainers.init-config.env[5].value | string | `"{{ .Values.secret.ZIGBEE2MQTT_CONFIG_MQTT_USER }}"` |  |
| initContainers.init-config.env[6].name | string | `"ZIGBEE2MQTT_CONFIG_MQTT_PASSWORD"` |  |
| initContainers.init-config.env[6].value | string | `"{{ .Values.secret.ZIGBEE2MQTT_CONFIG_MQTT_PASSWORD }}"` |  |
| initContainers.init-config.env[7].name | string | `"ZIGBEE2MQTT_CONFIG_MQTT_BASE_TOPIC"` |  |
| initContainers.init-config.env[7].value | string | `"{{ .Values.env.ZIGBEE2MQTT_CONFIG_MQTT_BASE_TOPIC }}"` |  |
| initContainers.init-config.env[8].name | string | `"ZIGBEE2MQTT_CONFIG_SERIAL_PORT"` |  |
| initContainers.init-config.env[8].value | string | `"{{ .Values.env.ZIGBEE2MQTT_CONFIG_SERIAL_PORT }}"` |  |
| initContainers.init-config.env[9].name | string | `"ZIGBEE2MQTT_CONFIG_SERIAL_ADAPTER"` |  |
| initContainers.init-config.env[9].value | string | `"{{ .Values.env.ZIGBEE2MQTT_CONFIG_SERIAL_ADAPTER }}"` |  |
| initContainers.init-config.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.init-config.volumeMounts[0].mountPath | string | `"/data"` |  |
| initContainers.init-config.volumeMounts[0].name | string | `"data"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.ZIGBEE2MQTT_CONFIG_MQTT_PASSWORD | string | `""` |  |
| secret.ZIGBEE2MQTT_CONFIG_MQTT_USER | string | `""` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10103` |  |

All Rights Reserved - The TrueCharts Project
