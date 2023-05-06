{{- define "immich.config" -}}
  {{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
  {{- $secretName := printf "%s-secret" $fname -}}
  {{- $jwtSecret := randAlphaNum 32 -}}
  {{- $typesenseKey := randAlphaNum 32 -}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
    {{- $jwtSecret = index .data "JWT_SECRET" | b64dec -}}
    {{- $typesenseKey = index .data "TYPESENSE_API_KEY" | b64dec -}}
  {{- end }}

configmap:
  web-config:
    enabled: true
    data:
      PORT: {{ .Values.service.web.ports.web.port | quote }}
  server-config:
    enabled: true
    data:
      {{/* User Defined */}}
      DISABLE_REVERSE_GEOCODING: {{ .Values.immich.disable_reverse_geocoding | quote }}
      REVERSE_GEOCODING_PRECISION: {{ .Values.immich.reverse_geocoding_precision | quote }}
      ENABLE_MAPBOX: {{ .Values.immich.mapbox_enable | quote }}
      SERVER_PORT: {{ .Values.service.server.ports.server.port | quote }}
  micro-config:
    enabled: true
    data:
      MICROSERVICES_PORT: {{ .Values.service.microservices.ports.microservices.port | quote }}
      REVERSE_GEOCODING_DUMP_DIRECTORY: {{ .Values.persistence.microcache.targetSelector.microservices.microservices.mountPath }}
  {{- if .Values.immich.enable_ml }}
  ml-config:
    enabled: true
    data:
      MACHINE_LEARNING_PORT: {{ .Values.service.machinelearning.ports.machinelearning.port | quote }}
      TRANSFORMERS_CACHE: {{ .Values.persistence.mlcache.targetSelector.machinelearning.machinelearning.mountPath }}
  {{- end }}
  common-config:
    enabled: true
    data:
      IMMICH_WEB_URL: {{ printf "http://%v-web:%v" $fname .Values.service.web.ports.web.port }}
      IMMICH_SERVER_URL: {{ printf "http://%v-server:%v" $fname .Values.service.server.ports.server.port }}
      {{- if .Values.immich.enable_ml }}
      IMMICH_MACHINE_LEARNING_URL: {{ printf "http://%v-machinelearning:%v" $fname .Values.service.machinelearning.ports.machinelearning.port }}
      {{- else }}
      IMMICH_MACHINE_LEARNING_URL: "false"
      {{- end }}
      TYPESENSE_ENABLED: {{ .Values.immich.enable_typesense | quote }}
      {{- if .Values.immich.enable_typesense }}
      TYPESENSE_URL: {{ printf "http://%v-typesense:%v" $fname .Values.service.typesense.ports.typesense.port }}
      TYPESENSE_PROTOCOL: http
      TYPESENSE_HOST: {{ printf "%v-typesense" $fname }}
      TYPESENSE_PORT: {{ .Values.service.typesense.ports.typesense.port | quote }}
      {{- end }}
      {{/*
      Its unclear where this URL is being used, but poking in their code, seems to be used internally?
      Its set to the value of IMMICH_SERVER_URL on their compose. If something doesnt work remotely,
      This is the place to start looking
      https://github.com/immich-app/immich/blob/b5d75e20167b92de12cc50a816da214779cb0807/web/src/api/api.ts#L55
      */}}
      PUBLIC_IMMICH_SERVER_URL: {{ printf "http://%v-server:%v" $fname .Values.service.server.ports.server.port }}
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
      TYPESENSE_DATA_DIR: {{ .Values.persistence.typesense.targetSelector.typesense.typesense.mountPath }}
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
