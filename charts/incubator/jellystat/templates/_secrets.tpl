{{/* Define the secrets */}}
{{- define "jellystat.secrets" -}}
{{- $secretName := (printf "%s-jellystat-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $jellystatprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  {{- if $jellystatprevious }}
  JWT_SECRET: {{ index $jellystatprevious.data "JWT_SECRET" | b64dec }}
  {{- else }}
  {{- $JWT_SECRET := randAlphaNum 64 }}
  JWT_SECRET: {{ $JWT_SECRET }}
  {{- end }}

{{- end -}}
