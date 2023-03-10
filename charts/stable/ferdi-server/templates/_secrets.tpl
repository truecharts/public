{{/* Define the secrets */}}
{{- define "ferdi-server.secrets" -}}
data:
  {{- if $ferdiprevious}}
  APP_KEY: {{ index $ferdiprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
