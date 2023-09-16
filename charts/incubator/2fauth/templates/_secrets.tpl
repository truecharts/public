{{/* Define the secrets */}}
{{- define "fauth.secrets" -}}
{{- $secretName := (printf "%s-fauth-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $appKey := (printf "%v" (randAlphaNum 32 | b64enc)) -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $appKey = index .data "APP_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  APP_KEY: {{ $appKey }}
{{- end -}}
