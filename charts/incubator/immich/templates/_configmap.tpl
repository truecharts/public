{{/* Define the configmap */}}
{{- define "immich.config" -}}

{{- $configName := printf "%s-immich-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  NODE_ENV: production
  DB_HOSTNAME: {{ printf "%v-%v" .Release.Name "postgresql" }}
  DB_USERNAME: {{ .Values.postgresql.postgresqlUsername }}
  DB_DATABASE_NAME: {{ .Values.postgresql.postgresqlDatabase }}
  DB_PORT: "5432"
  REDIS_HOSTNAME: {{ printf "%v-%v" .Release.Name "redis" }}
  REDIS_PORT: "6379"
  REDIS_DBINDEX: "0"
  {{/* User Defined */}}
  LOG_LEVEL: {{ .Values.immich.log_level }}
  DISABLE_REVERSE_GEOCODING: {{ .Values.immich.disable_reverse_geocoding}}
  REVERSE_GEOCODING_PRECISION: {{ .Values.immich.reverse_geocoding_precision | quote }}
  PUBLIC_LOGIN_PAGE_MESSAGE: {{ .Values.immich.public_login_page_message }}
{{- end -}}
