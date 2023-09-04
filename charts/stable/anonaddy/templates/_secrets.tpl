{{/* Define the secrets */}}
{{- define "anonaddy.secrets" -}}
{{- $secretName := (printf "%s-anonaddy-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $appKey := randAlphaNum 64 -}}
{{- $secretKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $appKey = index .data "APP_KEY" | b64dec -}}
   {{- $secretKey = index .data "ANONADDY_SECRET" | b64dec -}}
 {{- end }}
enabled: true
data:
  APP_KEY: {{ $appKey }}
  ANONADDY_SECRET: {{ $secretKey }}
{{- end -}}
