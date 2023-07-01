{{/* Define the secrets */}}
{{- define "ghostfolio.secrets" -}}
{{- $secretName := (printf "%s-ghostfolio-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}

{{/* Initialize all keys */}}
{{- $accesstokensalt := randAlphaNum 50 }}
{{- $jwtsecret := randAlphaNum 50 }}

  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) -}}
    {{/* Get previous values and decode */}}
    {{- $accesstokensalt = (index .data "ACCESS_TOKEN_SALT") | b64dec -}}
    {{- $jwtsecret = (index .data "JWT_SECRET_KEY") | b64dec -}}
  {{- end }}

enabled: true
data:
  ACCESS_TOKEN_SALT: {{ $accesstokensalt }}
  JWT_SECRET_KEY: {{ $jwtsecret }}
  DATABASE_URL: {{ (printf "%s?client_encoding=utf8" (.Values.cnpg.main.creds.std | trimAll "\"")) | quote }}
{{- end -}}
