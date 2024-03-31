{{/* Define the secrets */}}
{{- define "speedtest-tracker.secrets" -}}
{{- $secretName := (printf "%s-speedtest-tracker-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}
{{- $key := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $key = index .data "APP_KEY" | b64dec -}}
{{- end }}
enabled: true
data:
  APP_KEY: {{ $key }}
{{- end -}}
