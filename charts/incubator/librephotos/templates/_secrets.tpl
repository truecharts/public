{{/* Define the secrets */}}
{{- define "librephotos.secrets" -}}
{{- $secretName := (printf "%s-librephotos-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $secretKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $secretKey = index .data "SECRET_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  SECRET_KEY: {{ $secretKey | b64enc }}
{{- end -}}
