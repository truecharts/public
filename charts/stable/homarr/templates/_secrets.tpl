{{/* Define the secrets */}}
{{- define "homarr.secrets" -}}
{{- $secretName := (printf "%s-homarr-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $homarrprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $homarrprevious }}
  NEXTAUTH_SECRET: {{ index $homarrprevious.data "NEXTAUTH_SECRET" | b64dec }}
  {{- else }}
  {{- $nextauth_secret := randAlphaNum 32 }}
  NEXTAUTH_SECRET: {{ $nextauth_secret }}
  {{- end }}

{{- end -}}
