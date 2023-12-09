{{/* Define the secret */}}
{{- define "wbo.secrets" -}}

{{- $secretName := (printf "%s-wbo-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

data:
  {{- with .Values.wbo.auth_secret_key }}
  AUTH_SECRET_KEY: {{ . | b64enc }}
  {{- end }}

{{- end }}
