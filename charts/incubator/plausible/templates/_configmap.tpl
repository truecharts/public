{{- define "plausible.configmap" -}}
enabled: true
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
{{- end }}
