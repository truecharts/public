{{/* Define the secrets */}}
{{- define "twofauth.secret" -}}
  {{- $secretName := (printf "%s-twofauth-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

  {{- $appKey := randAlphaNum 32 -}}

  {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
    {{- $appKey = index .data "APP_KEY" | b64dec -}}
  {{- end }}
enabled: true
data:
  APP_KEY: {{ $appKey }}
{{- end -}}
