{{/* Define the secrets */}}
{{- define "outline.secrets" -}}
{{- $secretName := (printf "%s-outline-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $outlineprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $outlineprevious }}
  SECRET_KEY: {{ index $outlineprevious.data "SECRET_KEY" | b64dec }}
  UTILS_SECRET: {{ index $outlineprevious.data "UTILS_SECRET"| b64dec }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  {{- $utils_secret := randAlphaNum 32 }}
  {{/* Outline wants a HEX 32 char string */}}
  SECRET_KEY: {{ (printf "%x" $secret_key) }}
  UTILS_SECRET: {{ (printf "%x" $utils_secret) }}
  {{- end }}

{{- end -}}
