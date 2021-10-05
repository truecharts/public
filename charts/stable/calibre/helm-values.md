# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env | object | See below | environment variables. See [image docs](https://docs.linuxserver.io/images/docker-calibre#environment-variables-e) for more details. |
| env.CLI_ARGS | string | `nil` | Optionally pass cli start arguments to calibre. |
| env.GUAC_PASS | string | `nil` | Password's md5 hash for the calibre gui |
| env.GUAC_USER | string | `nil` | Username for the calibre gui |
| env.PUID | int | `568` | Specify the user ID the application will run as |
| env.TZ | string | `"UTC"` | Set the container timezone |
| env.UMASK_SET | string | `"022"` | for umask setting of Calibre, default if left unset is 022. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"ghcr.io/linuxserver/calibre"` | image repository |
| image.tag | string | `"version-v5.26.0@sha256:b5ab76091fedea53422e0f4ab57c9a672f23599e0c6c003d11df1f6161a7006e"` | image tag |
| persistence | object | See values.yaml | Configure persistence settings for the chart under this key. |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service | object | See values.yaml | Configures service settings for the chart. |

All Rights Reserved - The TrueCharts Project
