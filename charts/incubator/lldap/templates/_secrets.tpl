{{/* Define the secrets */}}
{{- define "lldap.secrets" -}}
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $fetchname := printf "%s-lldap-secrets" $basename -}}

{{/* Initialize all keys */}}
{{- $jwtSecret := randAlphaNum 50 }}

data:
  {{ with (lookup "v1" "Secret" .Release.Namespace $fetchname) }}
    {{/* Get previous values and decode */}}
    {{ $jwtSecret = (index .data "LLDAP_JWT_SECRET") | b64dec }}
  {{ end }}
  LLDAP_JWT_SECRET: {{ $jwtSecret }}
{{- end -}}
