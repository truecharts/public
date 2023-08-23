{{/* Define the secrets */}}
{{- define "saltrim.secrets" -}}
{{- $secretName := (printf "%s-saltrim-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $saltrimprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $saltrimprevious }}
  MEILI_MASTER_KEY: {{ index $saltrimprevious.data "MEILI_MASTER_KEY" | b64dec }}
  APP_KEY: {{ index $saltrimprevious.data "APP_KEY" | b64dec }}
  {{- else }}
  {{- $MEILI_MASTER_KEY := randAlphaNum 64 }}
  MEILI_MASTER_KEY: {{ $MEILI_MASTER_KEY }}
  {{- $APP_KEY := randAlphaNum 64 }}
  APP_KEY: {{ $APP_KEY }}
  {{- end }}

{{- end -}}
