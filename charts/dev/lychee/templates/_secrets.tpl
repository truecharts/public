{{/* Define the secrets */}}
{{- define "lychee.secrets" -}}
enabled: true
{{- $lycheeprevious := lookup "v1" "Secret" .Release.Namespace "lychee-secrets" }}
{{- $app_key := "" }}
data:
  {{- if $lycheeprevious}}
  APP_KEY: {{ index $lycheeprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key }}
  {{- end }}

{{- end -}}
