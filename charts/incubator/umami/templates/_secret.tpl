{{/* Define the secret */}}
{{- define "umami.secret" -}}

{{- $secretName := (printf "%s-umami-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

data:
  {{/* Secret Key */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  HASH_SALT: {{ index .data "HASH_SALT" }}
  {{- else }}
  HASH_SALT: {{ randAlphaNum 32 }}
  {{- end }}
{{- end }}
