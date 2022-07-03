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
  BASE_URL: {{ .Values.plausible.BASE_URL }}
  DISABLE_AUTH: {{ .Values.plausible.DISABLE_AUTH }}
  DISABLE_REGISTRATION: {{ .Values.plausible.DISABLE_REGISTRATION }}

  CLICKHOUSE_FLUSH_INTERVAL_MS: {{ .Values.plausible.CLICKHOUSE_FLUSH_INTERVAL_MS }}
  CLICKHOUSE_MAX_BUFFER_SIZE: {{ .Values.plausible.CLICKHOUSE_MAX_BUFFER_SIZE }}

  SMTP_HOST_ADDR: {{ .Values.plausible.SMTP_HOST_ADDR }}
  SMTP_HOST_PORT: {{ .Values.plausible.SMTP_HOST_PORT }}
  SMTP_HOST_SSL_ENABLED: {{ .Values.plausible.SMTP_HOST_SSL_ENABLED }}
  SMTP_RETRIES: {{ .Values.plausible.SMTP_RETRIES }}
  MAILER_ADAPTER: {{ .Values.plausible.MAILER_ADAPTER }}
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

  ADMIN_USER_NAME: {{ .Values.plausible.ADMIN_USER_NAME }}
  ADMIN_USER_EMAIL: {{ .Values.plausible.ADMIN_USER_EMAIL }}
  ADMIN_USER_PWD: {{ .Values.plausible.ADMIN_USER_PWD | quote }}

  DATABASE_URL: {{ get .Values.postgresql.url "complete-noql" }}
  {{- /* CLICKHOUSE_DATABASE_URL: TODO */}}

  MAILER_EMAIL: {{ .Values.plausible.MAILER_EMAIL }}
  SMTP_USER_NAME: {{ .Values.plausible.SMTP_USER_NAME }}
  SMTP_USER_PWD: {{ .Values.plausible.SMTP_USER_PWD | quote }}
  POSTMARK_API_KEY: {{ .Values.plausible.POSTMARK_API_KEY | quote }}

  GOOGLE_CLIENT_ID: {{ .Values.plausible.GOOGLE_CLIENT_ID }}
  GOOGLE_CLIENT_SECRET: {{ .Values.plausible.GOOGLE_CLIENT_SECRET | quote }}
{{- end }}
