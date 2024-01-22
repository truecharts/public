{{/* Define the secrets */}}
{{- define "cloudreve.secrets" -}}
{{- $secretName := (printf "%s-cloudreve-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $rpcKey := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $rpcKey = index .data "RPC_SECRET" | b64dec -}}
{{- end }}
enabled: true
data:
  RPC_SECRET: {{ $rpcKey }}
{{- end -}}
