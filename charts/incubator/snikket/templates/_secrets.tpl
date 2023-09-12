{{/* Define the secrets */}}
{{- define "snikket.secrets" -}}
{{- $secretName := (printf "%s-snikket-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $webKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $webKey = index .data "SNIKKET_WEB_SECRET_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  SNIKKET_WEB_SECRET_KEY: {{ $webKey }}
{{- end -}}
