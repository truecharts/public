{{- define "homarr.secrets" -}}
{{- $secretName := (printf "%s-homarr-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $secret := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $secret = index .data "NEXTAUTH_SECRET" | b64dec -}}
{{- end }}
enabled: true
data:
  NEXTAUTH_SECRET: {{ $secret }}
{{- end -}}
