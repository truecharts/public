{{/* Define the secrets */}}
{{- define "paperlessng.secrets" -}}

data:
  {{- if $paperlessprevious}}
  PAPERLESS_SECRET_KEY: {{ index $paperlessprevious.data "PAPERLESS_SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  PAPERLESS_SECRET_KEY: {{ $secret_key | b64enc  }}
  {{- end }}

{{- end -}}
