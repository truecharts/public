{{/* Define the secrets */}}
{{- define "lynx.secrets" -}}
{{- $secretName := (printf "%s-lynx-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $jwtKey := randAlphaNum 32 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $jwtKey = index .data "JWT_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  JWT_KEY: {{ $jwtKey }}
{{- end -}}
