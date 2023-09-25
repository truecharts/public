{{- define "plausible.secret" -}}
{{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
{{- $secretName := printf "%s-secret" $fname -}}

{{- $plausible := .Values.plausible -}}
{{- $email := $plausible.email -}}
{{- $maxmind := $plausible.maxmind -}}
{{- $google := $plausible.google -}}

{{- $baseKey := randAlphaNum 64 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $baseKey = index .data "SECRET_KEY_BASE" | b64dec -}}
{{- end }}

enabled: true
data:
  SECRET_KEY_BASE: {{ $baseKey }}

  DATABASE_URL: {{ .Values.cnpg.main.creds.std }}
  CLICKHOUSE_DATABASE_URL: {{ .Values.clickhouse.creds.complete }}

  MAILER_EMAIL: {{ $email.mailer_email | quote }}
  MAILER_NAME: {{ $email.mailer_name | quote }}
  SMTP_USER_NAME: {{ $email.smtp_user_name | quote }}
  SMTP_USER_PWD: {{ $email.smtp_user_password | quote }}
  POSTMARK_API_KEY: {{ $email.postmark_api_key | quote }}
  MAILGUN_API_KEY: {{ $email.mailgun_api_key | quote }}
  MAILGUN_DOMAIN: {{ $email.mailgun_domain | quote }}
  MANDRILL_API_KEY: {{ $email.mandrill_api_key | quote }}
  SENDGRID_API_KEY: {{ $email.sendgrid_api_key | quote }}

  MAXMIND_LICENSE_KEY: {{ $maxmind.license_key | quote }}

  GOOGLE_CLIENT_ID: {{ $google.client_id | quote }}
  GOOGLE_CLIENT_SECRET: {{ $google.client_secret | quote }}
{{- end }}
