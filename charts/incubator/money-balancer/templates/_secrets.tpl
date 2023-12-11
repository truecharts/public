{{/* Define the secrets */}}
{{- define "moneybalancer.secrets" -}}

{{- $secretName := printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" .) }}
{{- $moneybalancerprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
{{- $jwt_secret := "" }}
enabled: true
data:
  {{- if $moneybalancerprevious}}
  JWT_SECRET: {{ index $moneybalancerprevious.data "JWT_SECRET" }}
  {{- else }}
  {{- $jwt_secret := randAlphaNum 32 }}
  JWT_SECRET: {{ $jwt_secret | b64enc }}
  {{- end }}

{{- end -}}
