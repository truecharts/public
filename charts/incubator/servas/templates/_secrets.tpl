{{/* Define the secrets */}}
{{- define "servas.secrets" -}}
{{- $secretName := (printf "%s-servas-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $servasprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $servasprevious }}
  APP_KEY: {{ index $servasprevious.data "APP_KEY" | b64dec }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key }}
  {{- end }}

{{- end -}}