{{/* Define the secrets */}}
{{- define "photoview.secrets" -}}
enabled: true
data:
  PHOTOVIEW_POSTGRES_URL: {{ (printf "%s?client_encoding=utf8" (.Values.cnpg.main.creds.std | trimAll "\"")) | quote }}
{{- end -}}
