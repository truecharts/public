{{/* Define the secrets */}}
{{- define "metabase.secrets" -}}

enabled: true
data:
  MB_DB_PASS: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}

{{- end -}}
