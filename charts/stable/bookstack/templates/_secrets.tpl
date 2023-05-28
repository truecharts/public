{{/* Define the secrets */}}
{{- define "bookstack.secrets" -}}
{{- $secretName := (printf "%s-bookstack-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $bookstackprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $bookstackprevious }}
  APP_KEY: {{ index $bookstackprevious.data "APP_KEY" | b64dec }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key }}
  {{- end }}

{{- end -}}
