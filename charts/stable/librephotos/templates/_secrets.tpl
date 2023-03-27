{{/* Define the secrets */}}
{{- define "librephotos.secrets" -}}
{{- $secretName := (printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $librephotosprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
{{- $secret_key := "" }}
data:
  {{- if $librephotosprevious}}
  SECRET_KEY: {{ index $librephotosprevious.data "SECRET_KEY" }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  SECRET_KEY: {{ $secret_key | b64enc }}
  {{- end }}

{{- end -}}
