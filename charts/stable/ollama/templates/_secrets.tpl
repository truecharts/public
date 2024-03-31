{{/* Define the secrets */}}
{{- define "ollama.secrets" -}}
{{- $secretName := (printf "%s-ollama-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $secretKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $secretKey = index .data "WEBUI_SECRET_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  WEBUI_SECRET_KEY: {{ $secretKey }}
{{- end -}}
