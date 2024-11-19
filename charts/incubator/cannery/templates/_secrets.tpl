{{/* Define the secrets */}}
{{- define "cannery.secrets" -}}

{{- $secretName := (printf "%s-cannery-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $pass_key := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $pass_key = index .data "SECRET_KEY_BASE" | b64dec -}}
{{- end }}
enabled: true
data:
  SECRET_KEY_BASE: {{ $pass_key }}
{{- end -}}