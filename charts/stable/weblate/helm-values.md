# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.POSTGRES_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.POSTGRES_PORT | int | `5432` |  |
| env.POSTGRES_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.REDIS_DB | string | `"0"` |  |
| env.REDIS_PORT | int | `6379` |  |
| env.WEBLATE_TIME_ZONE | string | `"{{ .Values.TZ }}"` |  |
| envFrom[0].configMapRef.name | string | `"weblate-env"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.POSTGRES_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.REDIS_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.key | string | `"redis-password"` |  |
| envValueFrom.REDIS_PASSWORD.secretKeyRef.name | string | `"rediscreds"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/weblate"` |  |
| image.tag | string | `"v4.11.2@sha256:b8217cb4e2ab878a7f8c67263b29276ff35699f1c55e1c7f13abfddae75c5a9c"` |  |
| persistence.cache.enabled | bool | `true` |  |
| persistence.cache.mountPath | string | `"/app/cache"` |  |
| persistence.cache.type | string | `"emptyDir"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/app/data"` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `1000` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"weblate"` |  |
| postgresql.postgresqlUsername | string | `"weblate"` |  |
| probes.liveness.path | string | `"/healthz"` |  |
| probes.readiness.path | string | `"/healthz"` |  |
| probes.startup.path | string | `"/healthz"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| redis.redisUsername | string | `"default"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `10158` |  |
| service.main.ports.main.targetPort | int | `8080` |  |
| weblate.auth | object | `{"azure":{},"azuretenant":{},"bitbucket":{},"facebook":{},"github":{},"gitlab":{},"google":{},"keycloak":{},"ldap":{},"linux":{},"saml":{},"slack":{}}` |  WEBLATE_MT_AWS_REGION: "" WEBLATE_MT_AWS_ACCESS_KEY_ID: "" WEBLATE_MT_AWS_SECRET_ACCESS_KEY: "" WEBLATE_MT_DEEPL_KEY: "" WEBLATE_MT_DEEPL_API_URL: "" WEBLATE_MT_LIBRETRANSLATE_KEY: "" WEBLATE_MT_LIBRETRANSLATE_API_URL: "" WEBLATE_MT_GOOGLE_KEY: "" WEBLATE_MT_GOOGLE_CREDENTIALS: "" WEBLATE_MT_GOOGLE_PROJECT: "" WEBLATE_MT_GOOGLE_LOCATION: "" WEBLATE_MT_MICROSOFT_COGNITIVE_KEY: "" WEBLATE_MT_MICROSOFT_ENDPOINT_URL: "" WEBLATE_MT_MICROSOFT_REGION: "" WEBLATE_MT_MICROSOFT_BASE_URL: "" WEBLATE_MT_MODERNMT_KEY: "" WEBLATE_MT_MYMEMORY_ENABLED: false WEBLATE_MT_GLOSBE_ENABLED: false WEBLATE_MT_MICROSOFT_TERMINOLOGY_ENABLED: false WEBLATE_MT_SAP_BASE_URL: "" WEBLATE_MT_SAP_SANDBOX_APIKEY: "" WEBLATE_MT_SAP_USERNAME: "" WEBLATE_MT_SAP_PASSWORD: "" WEBLATE_MT_SAP_USE_MT: false |
| weblate.auth.azure | object | `{}` |  WEBLATE_SOCIAL_AUTH_GITLAB_SECRET: "" WEBLATE_SOCIAL_AUTH_GITLAB_API_URL: "" |
| weblate.auth.azuretenant | object | `{}` |  WEBLATE_SOCIAL_AUTH_AZUREAD_OAUTH2_SECRET: "" |
| weblate.auth.bitbucket | object | `{}` |  WEBLATE_SOCIAL_AUTH_GITHUB_SECRET: "" WEBLATE_SOCIAL_AUTH_GITHUB_ORG_KEY: "" WEBLATE_SOCIAL_AUTH_GITHUB_ORG_SECRET: "" WEBLATE_SOCIAL_AUTH_GITHUB_ORG_NAME: "" WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_KEY: "" WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_SECRET: "" WEBLATE_SOCIAL_AUTH_GITHUB_TEAM_ID: "" |
| weblate.auth.facebook | object | `{}` |  WEBLATE_SOCIAL_AUTH_BITBUCKET_SECRET: "" |
| weblate.auth.github | object | `{}` |  WEBLATE_AUTH_LDAP_USER_DN_TEMPLATE: "" WEBLATE_AUTH_LDAP_USER_ATTR_MAP: "" WEBLATE_AUTH_LDAP_BIND_DN: "" WEBLATE_AUTH_LDAP_BIND_PASSWORD: "" WEBLATE_AUTH_LDAP_CONNECTION_OPTION_REFERRALS: "" WEBLATE_AUTH_LDAP_USER_SEARCH: "" WEBLATE_AUTH_LDAP_USER_SEARCH_FILTER: "" WEBLATE_AUTH_LDAP_USER_SEARCH_UNION: "" WEBLATE_AUTH_LDAP_USER_SEARCH_UNION_DELIMITER: "" |
| weblate.auth.gitlab | object | `{}` |  WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET: "" WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_WHITELISTED_DOMAINS: "" WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_WHITELISTED_EMAILS: "" |
| weblate.auth.google | object | `{}` |  WEBLATE_SOCIAL_AUTH_FACEBOOK_SECRET: "" |
| weblate.auth.keycloak | object | `{}` |  WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_SECRET: "" WEBLATE_SOCIAL_AUTH_AZUREAD_TENANT_OAUTH2_TENANT_ID: "" |
| weblate.auth.linux | object | `{}` |  WEBLATE_SOCIAL_AUTH_KEYCLOAK_SECRET: "" WEBLATE_SOCIAL_AUTH_KEYCLOAK_PUBLIC_KEY: "" WEBLATE_SOCIAL_AUTH_KEYCLOAK_ALGORITHM: "" WEBLATE_SOCIAL_AUTH_KEYCLOAK_AUTHORIZATION_URL: "" WEBLATE_SOCIAL_AUTH_KEYCLOAK_ACCESS_TOKEN_URL: "" |
| weblate.auth.saml | object | `{}` |  SOCIAL_AUTH_SLACK_SECRET: "" |
| weblate.auth.slack | object | `{}` |  WEBLATE_SOCIAL_AUTH_OPENSUSE: "" WEBLATE_SOCIAL_AUTH_UBUNTU: "" |
| weblate.email | object | `{}` |  |
| weblate.errorreport | object | `{}` |  WEBLATE_STATUS_URL: "" WEBLATE_LEGAL_URL: "" WEBLATE_PRIVACY_URL: "" |
| weblate.general.WEBLATE_SITE_DOMAIN | string | `"weblate.example.com"` |  |
| weblate.general.WEBLATE_SITE_TITLE | string | `"My Project's Weblate"` |  |
| weblate.localization | object | `{}` |  ROLLBAR_ENVIRONMENT: "" SENTRY_DSN: "" SENTRY_ENVIRONMENT: "" |
| weblate.machinetranslate | object | `{}` |  |
| weblate.siteintegration | object | `{}` |  WEBLATE_EMAIL_HOST: "" WEBLATE_EMAIL_HOST_USER: "" WEBLATE_EMAIL_HOST_PASSWORD: "" WEBLATE_EMAIL_USE_SSL: false WEBLATE_EMAIL_USE_TLS: false WEBLATE_EMAIL_BACKEND: "" |

All Rights Reserved - The TrueCharts Project
