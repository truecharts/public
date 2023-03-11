{{/* Define the secrets */}}
{{- define "pinry.secrets" -}}

data:
  {{- if $pinryprevious}}
  SECRET_KEY: {{ index $pinryprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
