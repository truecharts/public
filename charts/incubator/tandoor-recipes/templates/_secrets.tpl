{{/* Define the secrets */}}
{{- define "recipes.secrets" -}}
{{- $secretName := (printf "%s-recipes-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $secretKey := randAlphaNum 50 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $secretKey = index .data "SECRET_KEY" | b64dec -}}
{{- end }}
enabled: true
data:
  SECRET_KEY: {{ $secretKey }}
{{- end -}}
