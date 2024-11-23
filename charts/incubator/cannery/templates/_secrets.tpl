{{/* Define the secrets */}}
{{- define "cannery.secrets" -}}

{{- $secretName := (printf "%s-cannery-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $secret_key_base := randAlphaNum 64 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $secret_key_base = index .data "SECRET_KEY_BASE" | b64dec -}}
{{- end }}
enabled: true
data:
  SECRET_KEY_BASE: {{ $secret_key_base }}
{{- end -}}
