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
| env.AMCREST_HOST | string | `"localhost"` | Set the container timezone -- Host name used to connect to the Amcrest device |
| env.AMCREST_PORT | int | `80` | Port used to connect to the Amcrest device |
| env.HOME_ASSISTANT | string | `"false"` | Enable Home Assistant autodiscovery |
| env.HOME_ASSISTANT_PREFIX | string | `"homeassistant"` | Home Assistant autodiscovery prefix |
| env.MQTT_HOST | string | `"localhost"` | Host name used to connect to the MQTT broker |
| env.MQTT_PORT | int | `1883` | Port used to connect to the MQTT broker |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"tccr.io/truecharts/amcrest2mqtt"` | image repository |
| image.tag | string | `"v1.0.16@sha256:64d7a2487a2622ed163ff0dd9d518b9564f29c11438801a953da1d1bf931f18e"` | image tag |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| secret.AMCREST_PASSWORD | string | `"changeme"` | Password used to connect to the Amcrest device |
| secret.AMCREST_USERNAME | string | `"admin"` | User name used to connect to the Amcrest device |
| secret.MQTT_PASSWORD | string | `"changeme"` | Password used to connect to the MQTT broker |
| secret.MQTT_USERNAME | string | `"mqttuser"` | User name used to connect to the MQTT broker |
| service.main.enabled | bool | `false` |  |
| service.main.ports.main.enabled | bool | `false` |  |

All Rights Reserved - The TrueCharts Project
