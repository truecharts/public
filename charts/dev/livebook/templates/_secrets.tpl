{{/* Define the secrets */}}
{{- define "livebook.secrets" -}}
{{- $secretName := (printf "%s-livebook-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $secretKeyBase := randAlphaNum 48 | b64enc -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $secretKeyBase = index .data "LIVEBOOK_SECRET_KEY_BASE" | b64dec -}}
{{- end }}
enabled: true
data:
  LIVEBOOK_SECRET_KEY_BASE: {{ $secretKeyBase }}
{{- end -}}
