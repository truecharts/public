{{/* Define the secrets */}}
{{- define "plantit.secrets" -}}
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $fetchname := printf "%s-secret" $basename -}}

{{/* Initialize all keys */}}
{{- $secrets := randAlphaNum 50 }}

enabled: true
data:
  {{ with (lookup "v1" "Secret" .Release.Namespace $fetchname) }}
    {{/* Get previous values and decode */}}
    {{ $secrets = (index .data "PLANTIT_JWT_SECRET") | b64dec }}
  {{ end }}
  PLANTIT_JWT_SECRET: {{ $secrets }}
{{- end -}}
