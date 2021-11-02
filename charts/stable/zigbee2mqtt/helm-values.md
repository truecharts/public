# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config | object | See values.yaml | zigbee2mqtt configuration settings. This will be copied into the container's persistent storage at first run only. Further configuration should be done in the application itself! See [project documentation](https://www.zigbee2mqtt.io/information/configuration.html) for more information. these are mostly just defaults and any further tweaking should be done using env-vars |
| env | object | See below | environment variables. See [image docs](https://www.zigbee2mqtt.io/information/configuration.html#override-via-environment-variables) for more details. |
| env.ZIGBEE2MQTT_DATA | string | `"/data"` | Set the data folder for Zigbee2MQTT. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"koenkk/zigbee2mqtt"` | image repository |
| image.tag | string | `"1.22.0@sha256:a6c06a55616751cc5ac47897e0351143d979fbd6b7ca733f394946f8018db481"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| service | object | See values.yaml | Configures service settings for the chart. Normally this does not need to be modified. |

All Rights Reserved - The TrueCharts Project
