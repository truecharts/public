{{- define "plausible.secret" -}}
enabled: true
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace "plausible-secret") }}
  SECRET_KEY_BASE: {{ index .data "SECRET_KEY_BASE" | b64dec }}
  {{- else }}
  {{- /* The plain value of SECRET_KEY_BASE is also base64 encoded */}}
  SECRET_KEY_BASE: {{ randAlphaNum 86 | b64enc }}
  {{- end }}

  DATABASE_URL: {{ .Values.cnpg.main.creds.std }}
  CLICKHOUSE_DATABASE_URL: {{ .Values.clickhouse.creds.complete }}

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
