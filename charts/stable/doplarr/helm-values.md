# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.DISCORD__MAX_RESULTS | int | `25` |  |
| env.DISCORD__REQUESTED_MSG_STYLE | string | `":plain"` |  |
| env.LOG_LEVEL | string | `":info"` |  |
| env.OVERSEERR__URL | string | `""` |  |
| env.PARTIAL_SEASONS | bool | `true` |  |
| env.RADARR__QUALITY_PROFILE | string | `""` |  |
| env.RADARR__URL | string | `""` |  |
| env.SONARR__LANGUAGE_PROFILE | string | `""` |  |
| env.SONARR__QUALITY_PROFILE | string | `""` |  |
| env.SONARR__URL | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/doplarr"` |  |
| image.tag | string | `"v3.3.0@sha256:d08ec284876852d664fc6565c9a7fc823eceb78dc583d0323b280717732d13cc"` |  |
| probes.liveness.enabled | bool | `false` |  |
| probes.readiness.enabled | bool | `false` |  |
| probes.startup.enabled | bool | `false` |  |
| secret.DISCORD__ROLE_ID | string | `""` |  |
| secret.DISCORD__TOKEN | string | `""` |  |
| secret.OVERSEERR__API | string | `""` |  |
| secret.OVERSEERR__DEFAULT_ID | string | `""` |  |
| secret.RADARR__API | string | `""` |  |
| secret.SONARR__API | string | `""` |  |
| service.main.enabled | bool | `false` |  |
| service.main.ports.main.enabled | bool | `false` |  |

All Rights Reserved - The TrueCharts Project
