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
  DB_PASS: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
  DB_HOST: {{ printf "%v-%v" .Release.Name "postgresql" | b64enc }}
  DB_PORT: {{ printf "5432" | b64enc }}
  APP_TOKEN: {{ .Values.gsm.app_token | b64enc }}
  {{- with .Values.gsm.whitelist_guilds }}
  WHITELIST_GUILDS: {{ join ";" . | b64enc }}
  {{- end }}
{{- end }}
