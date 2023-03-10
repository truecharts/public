{{/* Define the secrets */}}
{{- define "fireflyiii.secrets" -}}

data:
  {{- if $fireflyiiiprevious}}
  STATIC_CRON_TOKEN: {{ index $fireflyiiiprevious.data "STATIC_CRON_TOKEN" }}
  APP_KEY: {{ index $fireflyiiiprevious.data "APP_KEY" }}
  {{- else }}
  {{- $static_cron_token := randAlphaNum 32 }}
  {{- $app_key := randAlphaNum 32 }}
  STATIC_CRON_TOKEN: {{ $static_cron_token | b64enc }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
