# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See more environment variables in the [amcrest2mqtt repo](https://github.com/dchesterton/amcrest2mqtt). |
| env.AMCREST_HOST | string | `""` | Host name used to connect to the Amcrest device |
| env.AMCREST_PORT | int | `80` | Port used to connect to the Amcrest device |
| env.HOME_ASSISTANT | string | `"false"` | Enable Home Assistant autodiscovery |
| env.HOME_ASSISTANT_PREFIX | string | `"homeassistant"` | Home Assistant autodiscovery prefix |
| env.MQTT_HOST | string | `"localhost"` | Host name used to connect to the MQTT broker |
| env.MQTT_PORT | int | `1883` | Port used to connect to the MQTT broker |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"dchesterton/amcrest2mqtt"` | image repository |
| image.tag | string | `"1.0.11@sha256:950a9ad1e91b151e7fbc84daa0b7663239020b596ffa68c009236a686b96ff5e"` | image tag |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| secret.AMCREST_PASSWORD | string | `"changeme"` | Password used to connect to the Amcrest device |
| secret.AMCREST_USERNAME | string | `"admin"` | User name used to connect to the Amcrest device |
| secret.MQTT_PASSWORD | string | `"changeme"` | Password used to connect to the MQTT broker |
| secret.MQTT_USERNAME | string | `"mqttuser"` | User name used to connect to the MQTT broker |
| service.main.enabled | bool | `false` |  |

All Rights Reserved - The TrueCharts Project
