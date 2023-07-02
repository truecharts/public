{{/* Define the secrets */}}
{{- define "photoview.secrets" -}}
{{- $secretName := (printf "%s-photoview-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}
enabled: true
data:
  PHOTOVIEW_POSTGRES_URL: {{ (printf "%s?client_encoding=utf8" (.Values.cnpg.main.creds.std | trimAll "\"")) | quote }}
{{- end -}}
