{{/* Define the secret */}}
{{- define "wbo.secret" -}}

enabled: true
data:
  {{- with .Values.wbo.auth_secret_key }}
  AUTH_SECRET_KEY: {{ . | b64enc }}
  {{- end }}

{{- end }}
