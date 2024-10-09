{{/* Define the secrets */}}
{{- define "baserow.secrets" -}}
{{- $secretName := (printf "%s-baserow-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $baserowprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $baserowprevious }}
  SECRET_KEY: {{ index $baserowprevious.data "SECRET_KEY" | b64dec }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key }}
  {{- end }}

{{- end -}}
