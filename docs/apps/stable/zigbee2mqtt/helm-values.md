# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.ZIGBEE2MQTT_CONFIG_EXPIRIMENTAL_NEW_API | bool | `true` |  |
| env.ZIGBEE2MQTT_CONFIG_FRONTEND_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.ZIGBEE2MQTT_CONFIG_MQTT_BASE_TOPIC | string | `"zigbee2mqtt"` |  |
| env.ZIGBEE2MQTT_CONFIG_MQTT_SERVER | string | `"mqtt://localhost"` |  |
| env.ZIGBEE2MQTT_CONFIG_PERMIT_JOIN | bool | `true` |  |
| env.ZIGBEE2MQTT_CONFIG_SERIAL_ADAPTER | string | `"auto"` |  |
| env.ZIGBEE2MQTT_CONFIG_SERIAL_PORT | string | `"/dev/ttyUSB0"` |  |
| env.ZIGBEE2MQTT_DATA | string | `"/data"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/zigbee2mqtt"` |  |
| image.tag | string | `"v1.24.0@sha256:2574cbd6af36d0305c8034804e2c64f672757133d71b14f87f36913a9b97e754"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.ZIGBEE2MQTT_CONFIG_MQTT_PASSWORD | string | `""` |  |
| secret.ZIGBEE2MQTT_CONFIG_MQTT_USER | string | `""` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10103` |  |

All Rights Reserved - The TrueCharts Project
