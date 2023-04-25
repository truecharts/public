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
    REDIS_HOST=localhost
    REDIS_PORT=6379

    # POSTGRES
    POSTGRES_DB={{ default "ghostfolio" $.Values.cnpg.main.creds.database }}

    ALPHA_VANTAGE_API_KEY=
{{- end -}}
