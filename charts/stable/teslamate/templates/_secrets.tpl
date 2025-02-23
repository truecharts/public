{{/* Define the secrets */}}
{{- define "teslamate.secrets" -}}
{{- $secretName := (printf "%s-teslamate-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $encryptionKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $encryptionKey = index .data "TESLAMATE_ENCRYPTION_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  TESLAMATE_ENCRYPTION_KEY: {{ $encryptionKey }}
{{- end -}}
