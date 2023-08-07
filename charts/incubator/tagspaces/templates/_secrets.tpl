{{/* Define the secrets */}}
{{- define "tagspaces.secrets" -}}
{{- $secretName := (printf "%s-tagspaces-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}
{{- $key := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $key = index .data "KEY" | b64dec -}}
{{- end }}
enabled: true
data:
  KEY: {{ $key }}
{{- end -}}
