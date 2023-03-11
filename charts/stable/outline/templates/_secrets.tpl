{{/* Define the secrets */}}
{{- define "outline.secrets" -}}

data:
  {{- if $outlineprevious}}
  SECRET_KEY: {{ index $outlineprevious.data "SECRET_KEY" }}
  UTILS_SECRET: {{ index $outlineprevious.data "UTILS_SECRET" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  {{- $utils_secret := randAlphaNum 32 }}
  {{/* Outline wants a HEX 32 char string */}}
  SECRET_KEY: {{ (printf "%x" $secret_key) | b64enc }}
  UTILS_SECRET: {{ (printf "%x" $utils_secret) | b64enc }}
  {{- end }}

{{- end -}}
