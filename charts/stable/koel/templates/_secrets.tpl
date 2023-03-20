{{/* Define the secrets */}}
{{- define "koel.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $koelprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
{{- $app_key := "" }}
data:
  {{- if $koelprevious}}
  APP_KEY: {{ index $koelprevious.data "APP_KEY" }}
  {{- else }}
  {{- $app_key := randAlphaNum 32 }}
  APP_KEY: {{ $app_key | b64enc }}
  {{- end }}

{{- end -}}
