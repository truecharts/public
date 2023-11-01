{{/* Define the secrets */}}
{{- define "kimai.secret" -}}
{{- $secretName := (printf "%s-kimai-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $app_secret := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $app_secret = index .data "APP_SECRET" | b64dec -}}
{{- end }}

kimai-secret:
  enabled: true
  data:
    APP_SECRET: {{ $app_secret }}
{{- end -}}
