{{/* Define the secrets */}}
{{- define "nocodb.secrets" -}}
{{- $secretName := printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" .) }}

{{- $auth_jwt_token := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $auth_jwt_token = index .data "NC_AUTH_JWT_SECRET" | b64dec -}}
{{- end }}
enabled: true
data:
  NC_AUTH_JWT_SECRET: {{ $auth_jwt_token }}
{{- end -}}
