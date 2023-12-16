{{/* Define the secrets */}}
{{- define "koel.secrets" -}}
enabled: true
{{- $koelprevious := lookup "v1" "Secret" .Release.Namespace "koel-secrets" }}
{{- $app_key := "" }}
data:
  {{- if $koelprevious}}
  APP_KEY: {{ index $koelprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key }}
  {{- end }}

{{- end -}}
