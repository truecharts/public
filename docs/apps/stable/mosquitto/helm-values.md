# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| auth.enabled | bool | `false` | By enabling this, `allow_anonymous` gets set to `false` in the mosquitto config. |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy |
| image.repository | string | `"eclipse-mosquitto"` | image repository |
| image.tag | string | `"2.0.14@sha256:64b7c1729f7d1fff46b5e884fc389071686b2f7ed116c3fc7e17cbcb50fa147e"` | image tag |
| persistence.configinc | object | See values.yaml | Configure a persistent volume to place *.conf mosquitto-config-files in. When enabled, this gets set as `include_dir` in the mosquitto config. |
| persistence.data | object | See values.yaml | Configure a persistent volume to place mosquitto data in. When enabled, this enables `persistence` and `persistence_location` in the mosquitto config. |
| service | object | See values.yaml | Configures service settings for the chart. Normally this does not need to be modified. |

All Rights Reserved - The TrueCharts Project
