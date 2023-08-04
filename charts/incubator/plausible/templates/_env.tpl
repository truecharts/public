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
  DISABLE_REGISTRATION: {{ .Values.plausible.DISABLE_REGISTRATION | quote }}
  LOG_FAILED_LOGIN_ATTEMPTS: {{ .Values.plausible.LOG_FAILED_LOGIN_ATTEMPTS | quote }}

  CLICKHOUSE_FLUSH_INTERVAL_MS: {{ .Values.plausible.CLICKHOUSE_FLUSH_INTERVAL_MS | quote }}
  CLICKHOUSE_MAX_BUFFER_SIZE: {{ .Values.plausible.CLICKHOUSE_MAX_BUFFER_SIZE | quote }}

  SMTP_HOST_ADDR: {{ .Values.plausible.SMTP_HOST_ADDR | quote }}
  SMTP_HOST_PORT: {{ .Values.plausible.SMTP_HOST_PORT | quote }}
  SMTP_HOST_SSL_ENABLED: {{ .Values.plausible.SMTP_HOST_SSL_ENABLED | quote }}
  SMTP_RETRIES: {{ .Values.plausible.SMTP_RETRIES | quote }}
  MAILER_ADAPTER: {{ .Values.plausible.MAILER_ADAPTER | quote }}
  MAILGUN_BASE_URI: {{ .Values.plausible.MAILGUN_BASE_URI | quote }}

  MAXMIND_EDITION: {{ .Values.plausible.MAXMIND_EDITION | quote }}

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

  DATABASE_URL: {{ .Values.cnpg.main.creds.std }}
  CLICKHOUSE_DATABASE_URL: {{ .Values.clickhouse.url.complete }}

  MAILER_EMAIL: {{ .Values.plausible.MAILER_EMAIL | quote }}
  MAILER_NAME: {{ .Values.plausible.MAILER_NAME | quote }}
  SMTP_USER_NAME: {{ .Values.plausible.SMTP_USER_NAME | quote }}
  SMTP_USER_PWD: {{ .Values.plausible.SMTP_USER_PWD | quote }}
  POSTMARK_API_KEY: {{ .Values.plausible.POSTMARK_API_KEY | quote }}
  MAILGUN_API_KEY: {{ .Values.plausible.MAILGUN_API_KEY | quote }}
  MAILGUN_DOMAIN: {{ .Values.plausible.MAILGUN_DOMAIN | quote }}
  MANDRILL_API_KEY: {{ .Values.plausible.MANDRILL_API_KEY | quote }}
  SENDGRID_API_KEY: {{ .Values.plausible.SENDGRID_API_KEY | quote }}

  MAXMIND_LICENSE_KEY: {{ .Values.plausible.MAXMIND_LICENSE_KEY | quote }}

  GOOGLE_CLIENT_ID: {{ .Values.plausible.GOOGLE_CLIENT_ID | quote }}
  GOOGLE_CLIENT_SECRET: {{ .Values.plausible.GOOGLE_CLIENT_SECRET | quote }}
{{- end }}
