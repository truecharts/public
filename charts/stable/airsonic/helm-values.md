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
| env.CONTEXT_PATH | string | `nil` | Used to set the base path for reverse proxies eg. /booksonic, /books, etc. |
| env.JAVA_OPTS | string | `nil` | For passing additional java options. For some reverse proxies, you may need to pass `JAVA_OPTS=-Dserver.use-forward-headers=true` for airsonic to generate the proper URL schemes. |
| env.PUID | int | `568` | Specify the user ID the application will run as |
| env.TZ | string | `"UTC"` | Set the container timezone |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/linuxserver/airsonic"` | image repository |
| image.tag | string | `"version-v10.6.2@sha256:0a0e49be383db9340c0a8258bb31c5916281ec18c8c3fb56006866d18f8e63e0"` | image tag |
| ingress.main | object | See values.yaml | Enable and configure ingress settings for the chart under this key. |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. Normally this does not need to be modified. |

All Rights Reserved - The TrueCharts Project
