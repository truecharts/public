{{/* Define the secrets */}}
{{- define "flowise.secrets" -}}
{{- $secretName := (printf "%s-flowise-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $flowiseprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $flowiseprevious }}
  PASSPHRASE: {{ index $flowiseprevious.data "PASSPHRASE" | b64dec }}
  {{- else }}
  {{- $pass_key := randAlphaNum 32 }}
  PASSPHRASE: {{ $pass_key }}
  {{- end }}

{{- end -}}
