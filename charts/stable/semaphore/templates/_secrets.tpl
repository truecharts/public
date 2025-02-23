{{/* Define the secrets */}}
{{- define "semaphore.secrets" -}}
{{- $secretName := (printf "%s-semaphore-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $accessKey := randAlphaNum 32 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $accessKey = index .data "SEMAPHORE_ACCESS_KEY_ENCRYPTION" | b64dec -}}
 {{- end }}
enabled: true
data:
  SEMAPHORE_ACCESS_KEY_ENCRYPTION: {{ $accessKey }}
{{- end -}}
