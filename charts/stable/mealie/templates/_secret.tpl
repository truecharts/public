{{/* Define the secret */}}
{{- define "mealie.secret" -}}
enabled: true
data:
  POSTGRES_PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
  {{- with .Values.mealie_backend.smtp.user }}
  SMTP_USER: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.smtp.password }}
  SMTP_PASSWORD: {{ . }}
  {{- end }}
{{- end }}
