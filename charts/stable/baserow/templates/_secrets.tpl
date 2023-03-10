{{/* Define the secrets */}}
{{- define "baserow.secrets" -}}

data:
  {{- if $baserowprevious}}
  SECRET_KEY: {{ index $baserowprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
