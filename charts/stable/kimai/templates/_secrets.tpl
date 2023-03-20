{{/* Define the secrets */}}
{{- define "kimai.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $kimaiprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
{{- $app_secret := "" }}
data:
  {{- if $kimaiprevious}}
  APP_SECRET: {{ index $kimaiprevious.data "APP_SECRET" }}
  {{- else }}
  {{- $app_secret := randAlphaNum 32 }}
  APP_SECRET: {{ $app_secret | b64enc }}
  {{- end }}

{{- end -}}
