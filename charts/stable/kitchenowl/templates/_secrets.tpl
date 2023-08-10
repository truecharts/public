{{/* Define the secrets */}}
{{- define "kitchenowl.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $kitchenowlprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}

enabled: true
data:
  {{- if $kitchenowlprevious }}
  JWT_SECRET_KEY: {{ index $kitchenowlprevious.data "JWT_SECRET_KEY" | b64dec }}
  {{- else }}
  {{- $jwtsecret := randAlphaNum 50 }}
  JWT_SECRET_KEY: {{ $jwtsecret }}
  {{- end }}

{{- end -}}
