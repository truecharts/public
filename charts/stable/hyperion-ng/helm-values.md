# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://docs.linuxserver.io/images/docker-airsonic#environment-variables-e) for more details. |
| env.PUID | int | `568` | Specify the user ID the application will run as |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"sirfragalot/hyperion.ng"` | image repository |
| image.tag | string | `"2.0.12@sha256:7a3610716c6881d4a2cd028de7c553cdc7f28e0b18c1b455f35ef5b3e947ed2a"` | image tag |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/root/.hyperion"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
