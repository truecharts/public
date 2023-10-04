{{/* Define the secrets */}}
{{- define "romm.secrets" -}}
{{- $secretName := (printf "%s-romm-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $authKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $authKey = index .data "ROMM_AUTH_SECRET_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  ROMM_AUTH_SECRET_KEY: {{ $authKey }}
{{- end -}}
