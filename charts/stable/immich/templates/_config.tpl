{{- define "immich.config" -}}
  {{- $secretName := printf "%s-secret" (include "tc.v1.common.lib.chart.names.fullname" .) -}}
  {{- $jwtSecret := randAlphaNum 32 -}}
  {{- $typesenseKey := randAlphaNum 32 -}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
    {{- $jwtSecret = index .data "JWT_SECRET" | b64dec -}}
    {{- $typesenseKey = index .data "TYPESENSE_API_KEY" | b64dec -}}
  {{- end }}

configmap:
  server-config:
    enabled: true
    data:
      {{/* User Defined */}}
      TYPESENSE_ENABLED: {{ .Values.immich.enable_typesense | quote }}
      DISABLE_REVERSE_GEOCODING: {{ .Values.immich.disable_reverse_geocoding | quote }}
      REVERSE_GEOCODING_PRECISION: {{ .Values.immich.reverse_geocoding_precision | quote }}
      ENABLE_MAPBOX: {{ .Values.immich.mapbox_enable | quote }}
  common-config:
    enabled: true
    data:
      IMMICH_WEB_URL: http://localhost:3000
      IMMICH_SERVER_URL: http://localhost:3001
      IMMICH_MACHINE_LEARNING_URL: http://localhost:3003
      {{- if .Values.immich.enable_typesense }}
      TYPESENSE_URL: http://localhost:8108
      TYPESENSE_PROTOCOL: http
      TYPESENSE_HOST: localhost
      TYPESENSE_PORT: "8108"
      {{- end }}
      {{/*
      Its unclear where this URL is being used, but poking in their code, seems to be used internally?
      Its set to the value of IMMICH_SERVER_URL on their compose. If something doesnt work remotely,
      This is the place to start looking
      https://github.com/immich-app/immich/blob/b5d75e20167b92de12cc50a816da214779cb0807/web/src/api/api.ts#L55
      */}}
      PUBLIC_IMMICH_SERVER_URL: http://localhost:3001
      NODE_ENV: production
      {{/* User Defined */}}
      {{- with .Values.immich.public_login_page_message }}
      PUBLIC_LOGIN_PAGE_MESSAGE: {{ . }}
      {{- end }}
      LOG_LEVEL: {{ .Values.immich.log_level }}

secret:
  typesense-secret:
    enabled: true
    data:
      {{/* Secret Key */}}
      TYPESENSE_API_KEY: {{ $typesenseKey }}
      TYPESENSE_DATA_DIR: /data
  secret:
    enabled: true
    data:
      {{/* Secret Key */}}
      JWT_SECRET: {{ $jwtSecret }}
      TYPESENSE_API_KEY: {{ $typesenseKey }}
      {{- with .Values.immich.mapbox_key }}
      MAPBOX_KEY: {{ . }}
      {{- end }}
  deps-secret:
    enabled: true
    data:
      DB_USERNAME: {{ .Values.cnpg.main.user }}
      DB_DATABASE_NAME: {{ .Values.cnpg.main.database }}
      DB_HOSTNAME: {{ .Values.cnpg.main.creds.host }}
      DB_PASSWORD: {{ .Values.cnpg.main.creds.password }}
      DB_PORT: "5432"
      REDIS_HOSTNAME: {{ .Values.redis.creds.plainhost }}
      REDIS_PASSWORD: {{ .Values.redis.creds.redisPassword }}
      REDIS_PORT: "6379"
      REDIS_DBINDEX: "0"
{{- end -}}
