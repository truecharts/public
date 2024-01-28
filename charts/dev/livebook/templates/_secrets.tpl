{{/* Define the secrets */}}
{{- define "livebook.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{/* Base64 encoding is intended, application expects a b64 formatted value */}}
{{- $secretKeyBase := randAlphaNum 48 | b64enc -}}
{{- $cookie := randAlphaNum 20 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $secretKeyBase = index .data "LIVEBOOK_SECRET_KEY_BASE" | b64dec -}}
  {{- $cookie = index .data "LIVEBOOK_COOKIE" | b64dec -}}
{{- end }}
enabled: true
data:
  LIVEBOOK_SECRET_KEY_BASE: {{ $secretKeyBase | quote }}
  LIVEBOOK_COOKIE: {{ $cookie | quote }}
  LIVEBOOK_PASSWORD: {{ .Values.livebook.password | quote }}
  AWS_SECRET_ACCESS_KEY: {{ .Values.livebook.awsCredentials.secretAccessKey | default "" | quote }}
{{- end -}}
