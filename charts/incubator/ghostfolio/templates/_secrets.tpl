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
  DATABASE_URL: {{ printf "postgresql://%v:%v@%v:5432/%v?connect_timeout=300&sslmode=prefer" .Values.cnpg.main.creds.user .Values.cnpg.main.creds.password .Values.cnpg.main.creds.host .Values.cnpg.main.database }}
  REDIS_PASSWORD: {{ .Values.redis.creds.redisPassword }}
{{- end -}}
