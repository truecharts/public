{{/* Define the secrets */}}
{{- define "hoarder.secrets" -}}
{{- $secretName := (printf "%s-ollama-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

{{- $secretKey := randAlphaNum 64 -}}
{{- $meiliKey := randAlphaNum 64 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $secretKey = index .data "NEXTAUTH_SECRET" | b64dec -}}
   {{- $meiliKey = index .data "MEILI_MASTER_KEY" | b64dec -}}
 {{- end }}
enabled: true
data:
  NEXTAUTH_SECRET: {{ $secretKey }}
  MEILI_MASTER_KEY: {{ $meiliKey }}
{{- end -}}
