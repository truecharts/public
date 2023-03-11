{{/* Define the secrets */}}
{{- define "recipes.secrets" -}}

data:
  {{- if $recipesprevious}}
  SECRET_KEY: {{ index $recipesprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 50 }}
  SECRET_KEY: {{ $secret_key | b64enc | quote }}
  {{- end }}

{{- end -}}
