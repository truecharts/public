{{/* Define the secrets */}}
{{- define "gravity.secrets" -}}
{{- $secretName := (printf "%s-gravity-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}
{{- $token := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $token = index .data "ADMIN_TOKEN" | b64dec -}}
{{- end }}
enabled: true
data:
  ADMIN_TOKEN: {{ $token }}
{{- end -}}
