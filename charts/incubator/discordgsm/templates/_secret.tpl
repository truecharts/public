{{/* Define the secret */}}
{{- define "gsm.secret" -}}

{{- $secretName := printf "%s-gsm-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DATABASE_URL: {{ .Values.postgresql.url.complete | trimAll "\"" | b64enc }}
  DB_CONNECTION {{ print "postgres" | b64enc }}
  APP_TOKEN: {{ .Values.gsm.app_token | b64enc }}
  {{- with .Values.gsm.whitelist_guilds }}
  WHITELIST_GUILDS: {{ join ";" . | b64enc }}
  {{- end }}
{{- end }}
