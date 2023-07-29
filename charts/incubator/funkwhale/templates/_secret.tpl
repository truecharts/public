{{/* Define the secret */}}
{{- define "funkwhale.secret" -}}
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $fetchname := printf "%s-secret" $basename -}}

enabled: true
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $fetchname) }}
  DJANGO_SECRET_KEY: {{ (index .data "DJANGO_SECRET_KEY") }}
  {{- else }}
  DJANGO_SECRET_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
{{- end -}}
