{{/* Define the secret */}}
{{- define "wbo.secret" -}}

{{- $secretName := (printf "%s-wbo-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

data:
  {{- with .Values.wbo.auth_secret_key }}
  AUTH_SECRET_KEY: {{ . }}
  {{- end }}

{{- end }}
