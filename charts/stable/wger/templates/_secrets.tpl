{{/* Define the secrets */}}
{{- define "wger.secrets" -}}
{{- $secretName := (printf "%s-wger-secret" (include "tc.v1.common.lib.chart.names.fullname" $)) }}

enabled: true
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SECRET_KEY: {{ index .data "SECRET_KEY" | b64dec }}
  {{- else }}
  SECRET_KEY: {{ randAlphaNum 32 }}
  {{- end }}
  {{- $redisPass := .Values.redis.redisPassword | trimAll "\"" }}
  DJANGO_CACHE_LOCATION: {{ printf "redis://%v:%v@%v-redis/%v" .Values.redis.redisUsername $redisPass .Release.Name .Values.redis.redisDatabase }}
  DJANGO_DB_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  EMAIL_HOST_USER: {{ .Values.wger.mail.email_host_user }}
  EMAIL_HOST_PASSWORD: {{ .Values.wger.mail.email_host_password }}
  {{- with .Values.wger.captcha.recaptha_public_key }}
  RECAPTCHA_PUBLIC_KEY: {{ . }}
  {{- end }}
  {{- with .Values.wger.captcha.recaptha_private_key }}
  RECAPTCHA_PRIVATE_KEY: {{ . }}
  {{- end }}

{{- end -}}
