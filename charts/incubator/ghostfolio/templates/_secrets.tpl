{{/* Define the secrets */}}
{{- define "ghostfolio.secrets" -}}
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $fetchname := printf "%s-ghostfolio-secrets" $basename -}}

{{/* Initialize all keys */}}
{{- $accesstokensalt := randAlphaNum 50 }}
{{- $jwtsecret := randAlphaNum 50 }}

  {{- with (lookup "v1" "Secret" .Release.Namespace $fetchname) -}}
    {{/* Get previous values and decode */}}
    {{- $accesstokensalt = (index .data "ACCESS_TOKEN_SALT") | b64dec -}}
    {{- $jwtsecret = (index .data "JWT_SECRET_KEY") | b64dec -}}
  {{- end }}
  
enabled: true
data:  
  ACCESS_TOKEN_SALT: {{ $accesstokensalt }}
  JWT_SECRET_KEY: {{ $jwtsecret }}
  DATABASE_URL: "postgresql://{{ default "ghostfolio" .Values.cnpg.main.creds.user }}:{{ .Values.cnpg.main.creds.password }}@{{ .Values.cnpg.main.creds.host }}:{{ default 5432 .Values.cnpg.main.creds.port }}"
  REDIS_PASSWORD: {{ .Values.redis.creds.redisPassword }}
{{- end -}}
