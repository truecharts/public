{{/* Define the secrets */}}
{{- define "livebook.secrets" -}}
{{- $secretName := (printf "%s-livebook-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $secretKeyBase := randAlphaNum 48 | b64enc -}}
{{- $cookie := randAlphaNum 20 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $secretKeyBase = index .data "LIVEBOOK_SECRET_KEY_BASE" | b64dec -}}
  {{- $cookie = index .data "LIVEBOOK_COOKIE" | b64dec -}}
{{- end }}
enabled: true
data:
  LIVEBOOK_SECRET_KEY_BASE: {{ $secretKeyBase }}
  LIVEBOOK_COOKIE: {{ $cookie }}
{{- end -}}
