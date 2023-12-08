{{/* Define the secrets */}}
{{- define "ctfd.secrets" -}}

{{- $secretName := (printf "%s-ctfd-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $secret_key := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $secret_key = index .data "SECRET_KEY" | b64dec -}}
{{- end }}
enabled: true
data:
  SECRET_KEY: {{ $secret_key }}
{{- end -}}
