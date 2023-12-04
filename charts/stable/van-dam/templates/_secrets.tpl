{{/* Define the secrets */}}
{{- define "vandam.secrets" -}}
{{- $secretName := (printf "%s-vandam-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $secretKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $secretKey = index .data "SECRET_KEY_BASE" | b64dec -}}
 {{- end }}
enabled: true
data:
  SECRET_KEY_BASE: {{ $secretKey }}
{{- end -}}
