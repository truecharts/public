{{/* Define the configmap */}}
{{- define "ghostfolio.configmap.paths" -}}
enabled: true
data:
  ACCESS_TOKEN_SALT: "/secrets/ACCESS_TOKEN_SALT"
  JWT_SECRET_KEY: "/secrets/JWT_SECRET_KEY"
  DATABASE_URL: "/secrets/DATABASE_URL"
  REDIS_PASSWORD: "/secrets/REDIS_PASSWORD"
{{- end -}}

{{- define "ghostfolio.configmap.configfile" -}}
enabled: true
data:
  .env: |
    COMPOSE_PROJECT_NAME=ghostfolio

    # CACHE
    REDIS_HOST={{ .Values.redis.creds.plain }}
    {{- with $redis := .Values.redisProvider }}
    REDIS_PORT={{ default 6379 $redis.port }}
    {{- end }}

    # POSTGRES
    POSTGRES_DB=POSTGRES_DB={{ .Values.cnpg.main.creds.database }}

    ALPHA_VANTAGE_API_KEY={{ .Values.alpha_vantage_api_key }}
{{- end -}}
