{{/* Define the secrets */}}
{{- define "2fauth.secrets" -}}
{{- $secretName := (printf "%s-2fauth-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $appKey := (printf "%v" (randAlphaNum 32 | b64enc)) -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $appKey = index .data "APP_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  APP_KEY: {{ $appKey }}
{{- end -}}
