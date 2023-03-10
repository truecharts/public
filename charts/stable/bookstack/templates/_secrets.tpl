{{/* Define the secrets */}}
{{- define "bookstack.secrets" -}}

data:
  {{- if $bookstackprevious}}
  APP_KEY: {{ index $bookstackprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
