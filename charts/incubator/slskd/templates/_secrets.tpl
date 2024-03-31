{{/* Define the secrets */}}
{{- define "slskd.secrets" -}}
{{- $secretName := (printf "%s-slskd-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $jwtKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $jwtKey = index .data "SLSKD_JWT_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  SLSKD_JWT_KEY: {{ $jwtKey }}
{{- end -}}
