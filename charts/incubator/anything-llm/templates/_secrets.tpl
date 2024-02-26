{{/* Define the secrets */}}
{{- define "anythinglmm.secrets" -}}
{{- $secretName := (printf "%s-anythinglmm-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $jwtSecret := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $jwtSecret = index .data "JWT_SECRET" | b64dec -}}
 {{- end }}
enabled: true
data:
  JWT_SECRET: {{ $jwtSecret }}
{{- end -}}
