{{/* Define the secrets */}}
{{- define "fireshare.secrets" -}}
{{- $secretName := (printf "%s-fireshare-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $secretKey := randAlphaNum 32 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $secretKey = index .data "SECRET_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  SECRET_KEY: {{ $secretKey }}
{{- end -}}
