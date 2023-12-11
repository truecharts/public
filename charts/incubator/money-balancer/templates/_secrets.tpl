{{/* Define the secrets */}}
{{- define "moneybalancer.secrets" -}}

{{- $secretName := printf "%s-moneybalancer-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}

enabled: true
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  JWT_SECRET: {{ index .data "JWT_SECRET" }}
  {{- else }}
  JWT_SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}

{{- end -}}
