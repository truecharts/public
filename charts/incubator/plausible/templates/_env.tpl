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
  BASE_URL: {{ .Values.BASE_URL }}
  DISABLE_AUTH: {{ .Values.DISABLE_AUTH }}
  DISABLE_REGISTRATION: {{ .Values.DISABLE_REGISTRATION }}

  CLICKHOUSE_FLUSH_INTERVAL_MS: {{ .Values.CLICKHOUSE_FLUSH_INTERVAL_MS }}
  CLICKHOUSE_MAX_BUFFER_SIZE: {{ .Values.CLICKHOUSE_MAX_BUFFER_SIZE }}

  SMTP_HOST_ADDR: {{ .Values.SMTP_HOST_ADDR }}
  SMTP_HOST_PORT: {{ .Values.SMTP_HOST_PORT }}
  SMTP_HOST_SSL_ENABLED: {{ .Values.SMTP_HOST_SSL_ENABLED }}
  SMTP_RETRIES: {{ .Values.SMTP_RETRIES }}
  MAILER_ADAPTER: {{ .Values.MAILER_ADAPTER }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SECRET_KEY_BASE: {{ index .stringData "SECRET_KEY_BASE" }}
  {{- else }}
  {{- /* The plain value of SECRET_KEY_BASE is also base64 encoded */}}
  SECRET_KEY_BASE: {{ randAlphaNum 65 | b64enc }}
  {{- end }}

  ADMIN_USER_NAME: {{ .Values.ADMIN_USER_NAME }}
  ADMIN_USER_EMAIL: {{ .Values.ADMIN_USER_EMAIL }}
  ADMIN_USER_PWD: {{ .Values.ADMIN_USER_PWD }}

  DATABASE_URL: {{ get .Values.postgresql.url "complete-noql" }}
  {{- /* CLICKHOUSE_DATABASE_URL: TODO */}}

  MAILER_EMAIL: {{ .Values.MAILER_EMAIL }}
  SMTP_USER_NAME: {{ .Values.SMTP_USER_NAME }}
  SMTP_USER_PWD: {{ .Values.SMTP_USER_PWD }}
  POSTMARK_API_KEY: {{ .Values.POSTMARK_API_KEY }}

  GOOGLE_CLIENT_ID: {{ .Values.GOOGLE_CLIENT_ID }}
  GOOGLE_CLIENT_SECRET: {{ .Values.GOOGLE_CLIENT_SECRET }}
{{- end }}
