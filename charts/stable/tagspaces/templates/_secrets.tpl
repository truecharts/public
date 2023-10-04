{{/* Define the secrets */}}
{{- define "tagspaces.secret" -}}
{{- $secretName := (printf "%s-tagspaces-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{- $key := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
  {{- $key = index .data "KEY" | b64dec -}}
{{- end }}

tagspaces-secret:
  enabled: true
  data:
    KEY: {{ $key }}
{{- end -}}
