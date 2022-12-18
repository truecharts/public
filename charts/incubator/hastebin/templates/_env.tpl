{{/* HastBin environment variables */}}
{{- define "hastebin.env" -}}
  {{- $configName := printf "%s-env-config" (include "tc.common.names.fullname" .) }}
  {{- $secretName := printf "%s-env-secret" (include "tc.common.names.fullname" .) }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PORT: {{ .Values.service.main.ports.main.port | quote }}
  KEY_LENGTH: {{ .Values.hastebin.key_length | quote }}
  MAX_LENGTH: {{ .Values.hastebin.max_length | quote }}
  STATIC_MAX_AGE: {{ .Values.hastebin.static_max_age | quote }}
  RECOMPRESS_STATIC_ASSETS: {{ .Values.hastebin.recompress_static_assets | quote }}
  KEYGENERATOR_TYPE: {{ .Values.hastebin.key_gen_type | quote }}

  {{/* //TODO */}}
  DOCUMENTS: {{ .Values.hastebin.documents | quote }}

  {{/* Logging */}}
  LOGGING_LEVEL: {{ .Values.logging.level | quote }}
  LOGGING_TYPE: {{ .Values.logging.type | quote }}
  LOGGING_COLORIZE: {{ .Values.logging.colorize | quote }}

  {{/* Rate Limits //TODO */}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Storage/Dependencies */}}
  STORAGE_TYPE: "postgres"
  STORAGE_PORT: "5432"
  STORAGE_EXPIRE_SECONDS: {{ .Values.hastebin.storage_expires_seconds | quote }}
  STORAGE_HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  STORAGE_DB: {{ .Values.postgresql.postgresqlDatabase }}
  STORAGE_USERNAME: {{ .Values.postgresql.postgresqlUsername }}
  STORAGE_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}

{{- end }}
