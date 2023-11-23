{{/* Define the secrets */}}
{{- define "fireflyiii.secrets" -}}
{{- $secretName := (printf "%s-firefly-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $appKey := randAlphaNum 32 -}}
{{- $cronToken := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $appKey = index .data "APP_KEY" | b64dec -}}
  {{- $cronToken = index .data "STATIC_CRON_TOKEN" | b64dec -}}
{{- end }}
enabled: true
data:
  STATIC_CRON_TOKEN: {{ $cronToken }}
  APP_KEY: {{ $appKey }}
{{- end -}}
