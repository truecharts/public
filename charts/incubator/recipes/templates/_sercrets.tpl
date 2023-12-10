{{/* Define the secrets */}}
{{- define "recipes.secrets" -}}
enabled: true
data:
  {{- $recipesprevious := lookup "v1" "Secret" .Release.Namespace "recipes-secrets" }}
  {{- $secret_key := "" }}
  {{- if $recipesprevious}}
  SECRET_KEY: {{ index $recipesprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 50 }}
  SECRET_KEY: {{ $secret_key | b64enc | quote }}
  {{- end }}

{{- end -}}
