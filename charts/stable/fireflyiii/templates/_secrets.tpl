{{/* Define the secrets */}}
{{- define "fireflyiii.secrets" -}}
{{- $secretName := (printf "%s-fireflyiii-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $fireflyiiiprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $fireflyiiiprevious }}
  STATIC_CRON_TOKEN: {{ index $fireflyiiiprevious.data "STATIC_CRON_TOKEN" | b64dec }}
  APP_KEY: {{ index $fireflyiiiprevious.data "APP_KEY" | b64dec }}
  {{- else }}
  {{- $static_cron_token := randAlphaNum 32 }}
  {{- $app_key := randAlphaNum 32 }}
  STATIC_CRON_TOKEN: {{ $static_cron_token }}
  APP_KEY: {{ $app_key }}
  {{- end }}

{{- end -}}
