{{/* Define the secrets */}}
{{- define "saltrim.secrets" -}}
{{- $secretName := (printf "%s-saltrim-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $appKey := randAlphaNum 64 -}}
{{- $meiliKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $appKey = index .data "APP_KEY" | b64dec -}}
   {{- $meiliKey = index .data "MEILI_MASTER_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  APP_KEY: {{ $appKey }}
  MEILI_MASTER_KEY: {{ $meiliKey }}
{{- end -}}
