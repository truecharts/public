{{/* Define the secrets */}}
{{- define "outline.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{/* Outline wants a HEX 32 char string */}}
{{- $secret_key := (printf "%x" (randAlphaNum 32)) }}
{{- $utils_secret := (printf "%x" (randAlphaNum 32)) }}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  {{- $secret_key = index .data "SECRET_KEY" | b64dec }}
  {{- $utils_secret = index .data "UTILS_SECRET" | b64dec }}
{{- end }}
enabled: true
data:
  SECRET_KEY: {{ $secret_key }}
  UTILS_SECRET: {{ $utils_secret  }}
  REDIS_CUSTOM_URL: {{ .Values.redis.creds.url | trimAll "\""  }}
{{- end -}}
