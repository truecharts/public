{{/* Define the secrets */}}
{{- define "reactiveresume.secrets" -}}
{{- $secretName := (printf "%s-reactiveresume-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $secretKey := randAlphaNum 64 -}}
{{- $jwtKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $secretKey = index .data "SECRET_KEY" | b64dec -}}
   {{- $jwtKey = index .data "JWT_SECRET" | b64dec -}}
 {{- end }}
enabled: true
data:
  SECRET_KEY: {{ $secretKey }}
  JWT_SECRET: {{ $jwtKey }}
{{- end -}}
