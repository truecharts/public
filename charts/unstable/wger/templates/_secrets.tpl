{{/* Define the secrets */}}
{{- define "wger.secrets" -}}

{{- $secretName := printf "%s-wger-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SECRET_KEY: {{ index .data "SECRET_KEY" }}
  {{- else }}
  SECRET_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- $redisPass := .Values.redis.redisPassword | trimAll "\"" }}
  DJANGO_CACHE_LOCATION: {{ printf "redis://%v:%v@%v-redis/%v" .Values.redis.redisUsername $redisPass .Release.Name .Values.redis.redisDatabase | b64enc }}
  DJANGO_DB_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
  EMAIL_HOST_USER: {{ .Values.wger.mail.email_host_user | b64enc }}
  EMAIL_HOST_PASSWORD: {{ .Values.wger.mail.email_host_password | b64enc }}
  {{- with .Values.wger.captcha.recaptha_public_key }}
  RECAPTCHA_PUBLIC_KEY: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.wger.captcha.recaptha_private_key }}
  RECAPTCHA_PRIVATE_KEY: {{ . | b64enc }}
  {{- end }}

{{- end -}}
