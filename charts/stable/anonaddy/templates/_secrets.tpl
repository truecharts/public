{{/* Define the secrets */}}
{{- define "anonaddy.secrets" -}}
{{- $secretName := (printf "%s-anonaddy-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $appKey := randAlphaNum 64 -}}
{{- $secretKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $appKey = index .data "APP_KEY" | b64dec -}}
   {{- $secretKey = index .data "ANONADDY_SECRET" | b64dec -}}
 {{- end }}
enabled: true
data:
  # Anonaddy requires APP_KEY to be in base 64 format presented in the container, so this b64enc here is intentional
  # https://github.com/anonaddy/docker/blob/master/README.md#app
  APP_KEY: {{ $appKey | b64enc }}
  # Anonaddy requires ANONADDY_SECRET to be a long string
  ANONADDY_SECRET: {{ $secretKey }}
{{- end -}}
