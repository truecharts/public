{{/* Define the secrets */}}
{{- define "pinry.secrets" -}}
{{- $secretName := (printf "%s-pinry-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $pinryprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $pinryprevious }}
  SECRET_KEY: {{ index $pinryprevious.data "SECRET_KEY" | b64dec }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key }}
  {{- end }}

{{- end -}}
