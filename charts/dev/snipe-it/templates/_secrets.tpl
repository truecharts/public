{{/* Define the secrets */}}
{{- define "snipeit.secrets" -}}
enabled: true
{{- $snipeitprevious := lookup "v1" "Secret" .Release.Namespace "secrets" }}
{{- $app_key := "" }}
data:
  {{- if $snipeitprevious}}
  APP_KEY: {{ index $snipeitprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
