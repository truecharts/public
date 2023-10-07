{{/* Define the secrets */}}
{{- define "watcharr.secrets" -}}
{{- $secretName := (printf "%s-watcharr-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $secretKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $secretKey = index .data "JWT_SECRET" | b64dec -}}
 {{- end }}
enabled: true
data:
  JWT_SECRET: {{ $secretKey }}
{{- end -}}
