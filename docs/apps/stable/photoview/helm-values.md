# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.MAPBOX_TOKEN | string | `""` |  |
| env.PHOTOVIEW_DATABASE_DRIVER | string | `"postgres"` |  |
| env.PHOTOVIEW_DISABLE_FACE_RECOGNITION | bool | `false` |  |
| env.PHOTOVIEW_DISABLE_RAW_PROCESSING | bool | `false` |  |
| env.PHOTOVIEW_DISABLE_VIDEO_ENCODING | bool | `false` |  |
| env.PHOTOVIEW_LISTEN_PORT | string | `"{{ .Values.service.main.ports.main.targetPort }}"` |  |
| env.PHOTOVIEW_MEDIA_CACHE | string | `"/cache"` |  |
| env.TZ | string | `"UTC"` |  |
| envValueFrom.PHOTOVIEW_POSTGRES_URL.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.PHOTOVIEW_POSTGRES_URL.secretKeyRef.name | string | `"dbcreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/photoview"` |  |
| image.tag | string | `"2.3.12@sha256:84a2a71f6efdf659bbe127dc017cc4ef5fab34a20ba1d5c9c75321c2a75b9531"` |  |
| persistence.cache.enabled | bool | `true` |  |
| persistence.cache.mountPath | string | `"/cache"` |  |
| persistence.photos.enabled | bool | `true` |  |
| persistence.photos.mountPath | string | `"/photos"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"photoview"` |  |
| postgresql.postgresqlUsername | string | `"photoview"` |  |
| service.main.ports.main.port | int | `10159` |  |
| service.main.ports.main.targetPort | int | `10159` |  |

All Rights Reserved - The TrueCharts Project
