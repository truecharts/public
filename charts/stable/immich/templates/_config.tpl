{{- define "immich.config" -}}
  {{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
  {{- $secretName := printf "%s-secret" $fname -}}
  {{- $typesenseKey := randAlphaNum 32 -}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
    {{- $typesenseKey = index .data "TYPESENSE_API_KEY" | b64dec -}}
  {{- end }}

configmap:
  web-config:
    enabled: true
    data:
      PORT: {{ .Values.service.web.ports.web.port | quote }}
      NODE_ENV: production
      IMMICH_SERVER_URL: {{ printf "http://%v-server:%v" $fname .Values.service.server.ports.server.port }}
      PUBLIC_IMMICH_SERVER_URL: {{ printf "http://%v-server:%v" $fname .Values.service.server.ports.server.port }}
      {{- with .Values.immich.public_login_page_message }}
      PUBLIC_LOGIN_PAGE_MESSAGE: {{ . }}
      {{- end }}

  server-config:
    enabled: true
    data:
      SERVER_PORT: {{ .Values.service.server.ports.server.port | quote }}

  micro-config:
    enabled: true
    data:
      MICROSERVICES_PORT: {{ .Values.service.microservices.ports.microservices.port | quote }}
      DISABLE_REVERSE_GEOCODING: {{ .Values.immich.disable_reverse_geocoding | quote }}
      REVERSE_GEOCODING_PRECISION: {{ .Values.immich.reverse_geocoding_precision | quote }}
      REVERSE_GEOCODING_DUMP_DIRECTORY: {{ .Values.persistence.microcache.targetSelector.microservices.microservices.mountPath }}

  {{- if .Values.immich.enable_ml }}
  ml-config:
    enabled: true
    data:
      NODE_ENV: production
      MACHINE_LEARNING_PORT: {{ .Values.service.machinelearning.ports.machinelearning.port | quote }}
      MACHINE_LEARNING_CACHE_FOLDER: {{ .Values.persistence.mlcache.targetSelector.machinelearning.machinelearning.mountPath }}
      TRANSFORMERS_CACHE: {{ .Values.persistence.mlcache.targetSelector.machinelearning.machinelearning.mountPath }}
  {{- end }}

  {{/* Server and Microservices */}}
  common-config:
    enabled: true
    data:
      NODE_ENV: production
      LOG_LEVEL: {{ .Values.immich.log_level }}
      {{- if .Values.immich.enable_ml }}
      IMMICH_MACHINE_LEARNING_URL: {{ printf "http://%v-machinelearning:%v" $fname .Values.service.machinelearning.ports.machinelearning.port }}
      {{- else }}
      IMMICH_MACHINE_LEARNING_URL: "false"
      {{- end }}
      TYPESENSE_ENABLED: {{ .Values.immich.enable_typesense | quote }}
      {{- if .Values.immich.enable_typesense }}
      TYPESENSE_PROTOCOL: http
      TYPESENSE_HOST: {{ printf "%v-typesense" $fname }}
      TYPESENSE_PORT: {{ .Values.service.typesense.ports.typesense.port | quote }}
      {{- end }}

  proxy-config:
    enabled: true
    data:
      IMMICH_WEB_URL: {{ printf "http://%v-web:%v" $fname .Values.service.web.ports.web.port }}
      IMMICH_SERVER_URL: {{ printf "http://%v-server:%v" $fname .Values.service.server.ports.server.port }}

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
      TYPESENSE_API_KEY: {{ $typesenseKey }}

  {{/* Server and Microservices */}}
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
