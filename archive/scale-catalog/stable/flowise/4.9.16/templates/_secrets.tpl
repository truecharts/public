{{/* Define the secrets */}}
{{- define "flowise.secrets" -}}
{{- $secretName := (printf "%s-flowise-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $secretKey := randAlphaNum 32 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $secretKey = index .data "FLOWISE_SECRETKEY_OVERWRITE" | b64dec -}}
 {{- end }}
enabled: true
data:
  FLOWISE_SECRETKEY_OVERWRITE: {{ $secretKey }}
{{- end -}}
