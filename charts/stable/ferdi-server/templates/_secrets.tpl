{{/* Define the secrets */}}
{{- define "ferdi-server.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $ferdiprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $ferdiprevious }}
  APP_KEY: {{ index $ferdiprevious.data "APP_KEY" | b64dec }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key }}
  {{- end }}

{{- end -}}
