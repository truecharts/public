{{/* Define the secrets */}}
{{- define "kitchenowl.secrets" -}}

{{- $secretName := printf "%s-kitchenowl-secrets" (include "tc.v1.common.lib.chart.names.fullname" $) }}

{{- $jwt := randAlphaNum 50 -}}
{{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
  {{- $jwt = index .data "JWT_SECRET_KEY" | b64dec -}}
{{- end }}

enabled: true
data:
  JWT_SECRET_KEY: {{ $jwt }}
{{- end -}}
