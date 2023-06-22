{{/* Define the secrets */}}
{{- define "kimai.secrets" -}}
{{- $secretName := (printf "%s-kimai-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $kimaiprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $bookstackprevious }}
  APP_SECRET: {{ index $kimaiprevious.data "APP_SECRET" | b64dec }}
  {{- else }}
  {{- $app_secret := randAlphaNum 32 }}
  APP_SECRET: {{ $app_secret }}
  {{- end }}

{{- end -}}
