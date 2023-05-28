{{/* Define the secrets */}}
{{- define "paperlessng.secrets" -}}
{{- $secretName := (printf "%s-paperlessng-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $paperlessprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $paperlessprevious }}
  PAPERLESS_SECRET_KEY: {{ index $paperlessprevious.data "PAPERLESS_SECRET_KEY" | b64dec }}
  {{- else }}
  {{- $secret_key := randAlphaNum 32 }}
  PAPERLESS_SECRET_KEY: {{ $secret_key }}
  {{- end }}

{{- end -}}
