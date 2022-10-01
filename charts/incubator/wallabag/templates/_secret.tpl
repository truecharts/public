{{/* Define the secret */}}
{{- define "wallabag.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  SYMFONY__ENV__SECRET: {{ index .data "SYMFONY__ENV__SECRET" }}
  {{- else }}
  SYMFONY__ENV__SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  SYMFONY__ENV__DATABASE_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
  {{- with .Values.wallabag.mail.pass }}
  SYMFONY__ENV__MAILER_PASSWORD: {{ . | b64enc }}
  {{- end }}
  SYMFONY__ENV__REDIS_PASSWORD: {{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}


{{- end }}
