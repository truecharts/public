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
| browserlessImage.repository | string | `"tccr.io/truecharts/browserless-chrome"` |  |
| browserlessImage.tag | string | `"v1.51.1-chrome@sha256:39b1e2641af7fb437a8dbe886dc8cb1f613835338f2d8f9c57516f97716d5467"` |  |
| env.CACHE_TYPE | string | `"redis"` |  |
| env.DISALLOW_ROBOT | bool | `false` |  ALLOW_ORIGIN: "" |
| env.NODE_ENV | string | `"production"` |  |
| env.NODE_NAME | string | `"{{ .Release.Name }}-{{ randAlphaNum 5 }}"` |  |
| env.PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| env.PUPPETEER_WS_ENDPOINT | string | `"ws://localhost:3000"` |  |
| env.TITLE_LENGTH_LIMIT | int | `150` |  |
| envValueFrom.REDIS_URL.secretKeyRef.key | string | `"url"` |  |
| envValueFrom.REDIS_URL.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/rsshub"` |  |
| image.tag | string | `"v2022-03@sha256:7b08f8f30371f62a30f09ce6a86f2ce8cdc03b485ed61568f90abf30106dfa41"` |  |
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
