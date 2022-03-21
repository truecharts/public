# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers.browserless.image | string | `"{{ .Values.browserlessImage.repository }}:{{ .Values.browserlessImage.tag }}"` |  |
| additionalContainers.browserless.name | string | `"browserless"` |  |
| additionalContainers.browserless.ports[0].containerPort | int | `3000` |  |
| additionalContainers.browserless.ports[0].name | string | `"main"` |  |
| browserlessImage.repository | string | `"browserless/chrome"` |  |
| browserlessImage.tag | string | `"latest@sha256:751dedb5701648844b2b91077cf4bb027efc1a4e0bec053f8d8a6b81802dfe86"` |  |
| env.CACHE_TYPE | string | `"redis"` |  |
| env.DISALLOW_ROBOT | bool | `false` |  |
| env.NODE_ENV | string | `"production"` |  |
| env.NODE_NAME | string | `"{{ .Release.Name }}-{{ randAlphaNum 5 }}"` |  |
| env.PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.PUPPETEER_WS_ENDPOINT | string | `"ws://localhost:3000"` |  |
| env.TITLE_LENGTH_LIMIT | int | `150` |  |
| envValueFrom.REDIS_URL.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.REDIS_URL.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"diygod/rsshub"` |  |
| image.tag | string | `"2022-03-19@sha256:53f7237edf291c7f2b3343161245ed658b43faff07ac260dec280f42681003fe"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| secret.BITBUCKET_PASSWORD | string | `""` |  |
| secret.BITBUCKET_USERNAME | string | `""` |  |
| secret.GITHUB_ACCESS_TOKEN | string | `""` |  |
| secret.GOOGLE_FONTS_API_KEY | string | `""` |  |
| secret.HTTP_BASIC_AUTH_NAME | string | `""` |  |
| secret.HTTP_BASIC_AUTH_PASS | string | `""` |  |
| secret.LASTFM_API_KEY | string | `""` |  |
| secret.TELEGRAM_TOKEN | string | `""` |  |
| secret.YOUTUBE_KEY | string | `""` |  |
| service.main.ports.main.port | int | `10191` |  |

All Rights Reserved - The TrueCharts Project
