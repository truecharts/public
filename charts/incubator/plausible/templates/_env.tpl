{{/* Plausible environment variables */}}
{{- define "plausible.env" -}}
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
  BASE_URL: {{ .Values.plausible.BASE_URL | quote }}
  DISABLE_AUTH: {{ .Values.plausible.DISABLE_AUTH | quote }}
  DISABLE_REGISTRATION: {{ .Values.plausible.DISABLE_REGISTRATION | quote }}

  CLICKHOUSE_FLUSH_INTERVAL_MS: {{ .Values.plausible.CLICKHOUSE_FLUSH_INTERVAL_MS | quote }}
  CLICKHOUSE_MAX_BUFFER_SIZE: {{ .Values.plausible.CLICKHOUSE_MAX_BUFFER_SIZE | quote }}

  SMTP_HOST_ADDR: {{ .Values.plausible.SMTP_HOST_ADDR | quote }}
  SMTP_HOST_PORT: {{ .Values.plausible.SMTP_HOST_PORT | quote }}
  SMTP_HOST_SSL_ENABLED: {{ .Values.plausible.SMTP_HOST_SSL_ENABLED | quote }}
  SMTP_RETRIES: {{ .Values.plausible.SMTP_RETRIES | quote }}
  MAILER_ADAPTER: {{ .Values.plausible.MAILER_ADAPTER | quote }}

  LOG_LEVEL: {{ .Values.plausible.LOG_LEVEL | quote }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SECRET_KEY_BASE: {{ index .data "SECRET_KEY_BASE" | b64dec }}
  {{- else }}
  {{- /* The plain value of SECRET_KEY_BASE is also base64 encoded */}}
  SECRET_KEY_BASE: {{ randAlphaNum 65 | b64enc }}
  {{- end }}

  ADMIN_USER_NAME: {{ .Values.plausible.ADMIN_USER_NAME | quote }}
  ADMIN_USER_EMAIL: {{ .Values.plausible.ADMIN_USER_EMAIL | quote }}
  ADMIN_USER_PWD: {{ .Values.plausible.ADMIN_USER_PWD | quote }}

  DATABASE_URL: {{ get .Values.postgresql.url "complete-noql" }}
  CLICKHOUSE_DATABASE_URL: {{ .Values.clickhouse.url.complete }}

  MAILER_EMAIL: {{ .Values.plausible.MAILER_EMAIL | quote }}
  SMTP_USER_NAME: {{ .Values.plausible.SMTP_USER_NAME | quote }}
  SMTP_USER_PWD: {{ .Values.plausible.SMTP_USER_PWD | quote }}
  POSTMARK_API_KEY: {{ .Values.plausible.POSTMARK_API_KEY | quote }}

  GOOGLE_CLIENT_ID: {{ .Values.plausible.GOOGLE_CLIENT_ID | quote }}
  GOOGLE_CLIENT_SECRET: {{ .Values.plausible.GOOGLE_CLIENT_SECRET | quote }}
{{- end }}
