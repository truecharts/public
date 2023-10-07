{{/* Define the secret */}}
{{- define "funkwhale.secret" -}}
{{- $fetchname := printf "%s-secret" (include "tc.v1.common.lib.chart.names.fullname" $) -}}
{{- $key := randAlphaNum 32 -}}
{{- with (lookup "v1" "Secret" .Release.Namespace $fetchname) -}}
  {{- $key = index .data "DJANGO_SECRET_KEY" | b64dec -}}
{{- end }}
enabled: true
data:
  DJANGO_SECRET_KEY: {{ $key }}
{{- end -}}
