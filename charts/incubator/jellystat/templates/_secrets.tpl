{{/* Define the secrets */}}
{{- define "jellystat.secrets" -}}
{{- $secretName := (printf "%s-jellystat-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $jwtSecret := randAlphaNum 32 -}}
 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $jwtSecret = index .data "JWT_SECRET" | b64dec -}}
 {{- end }}
enabled: true
data:
  JWT_SECRET: {{ $jwtSecret }}
{{- end -}}
