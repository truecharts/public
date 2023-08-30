{{- define "plausible.configmap" -}}
{{- $plausible := .Values.plausible -}}
{{- $server := $plausible.server -}}
{{- $db := $plausible.db -}}
{{- $email := $plausible.email -}}
{{- $maxmind := $plausible.maxmind -}}
enabled: true
data:
  BASE_URL: {{ $server.base_url | quote }}
  LOG_LEVEL: {{ $server.log_level | quote }}
  DISABLE_REGISTRATION: {{ $server.disable_registration | quote }}
  LOG_FAILED_LOGIN_ATTEMPTS: {{  $server.log_failed_login_attempts | quote }}

  CLICKHOUSE_FLUSH_INTERVAL_MS: {{ $db.clickhouse_flush_interval_ms | quote }}
  CLICKHOUSE_MAX_BUFFER_SIZE: {{ $db.clickhouse_max_buffer_size | quote }}

  SMTP_HOST_ADDR: {{ $email.smtp_host_address | quote }}
  SMTP_HOST_PORT: {{ $email.smtp_host_port | quote }}
  SMTP_HOST_SSL_ENABLED: {{ $email.smtp_host_ssl_enabled | quote }}
  SMTP_RETRIES: {{ $email.smtp_retries | quote }}
  MAILER_ADAPTER: {{ $email.mailer_adapter | quote }}
  MAILGUN_BASE_URI: {{ $email.mailgun_base_uri | quote }}

  MAXMIND_EDITION: {{ $maxmind.edition | quote }}

{{- end }}
