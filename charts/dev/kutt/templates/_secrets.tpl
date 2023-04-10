{{/* Define the secrets */}}
{{- define "kutt.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $kuttprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
  name: kutt-secrets
{{- $jwt_secret := "" }}
data:
  {{- if $kuttprevious}}
  JWT_SECRET: {{ index $kuttprevious.data "JWT_SECRET" }}
  {{- else }}
  {{- $jwt_secret := randAlphaNum 32 }}
  JWT_SECRET: {{ $jwt_secret | b64enc }}
  {{- end }}

{{- end -}}
