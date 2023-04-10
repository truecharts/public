{{/* Define the secrets */}}
{{- define "inventree.secrets" -}}

{{- $secretName := printf "%s-secrets" (include "tc.v1.common.lib.chart.names.fullname" .) }}
data:
  {{- with lookup "v1" "Secret" .Release.Namespace $secretName }}
  INVENTREE_SECRET_KEY: {{ index .data "INVENTREE_SECRET_KEY" }}
  {{- else }}
  INVENTREE_SECRET_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- $redisPass := .Values.redis.redisPassword | trimAll "\"" }}
  INVENTREE_CACHE_HOST: {{ printf "%v:%v@%v-redis" .Values.redis.redisUsername $redisPass .Release.Name | b64enc }}
  {{- with .Values.inventree.credentials.admin_mail }}
  INVENTREE_ADMIN_EMAIL: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.inventree.credentials.admin_user }}
  INVENTREE_ADMIN_USER: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.inventree.credentials.admin_password }}
  INVENTREE_ADMIN_PASSWORD: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.inventree.mail.password }}
  INVENTREE_EMAIL_PASSWORD: {{ . | b64enc }}
  {{- end }}
{{- end -}}
