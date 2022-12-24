{{/* Define the secret */}}
{{- define "traggo.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  TRAGGO_DATABASE_DIALECT: sqlite3
  TRAGGO_DATABASE_CONNECTION: /opt/traggo/data/traggo.db
  TRAGGO_PORT: {{ .Values.service.main.ports.main.port | quote }}
  TRAGGO_PASS_STRENGTH: {{ .Values.traggo.pass_strength | quote }}
  TRAGGO_DEFAULT_USER_NAME: {{ .Values.traggo.username }}
  TRAGGO_DEFAULT_USER_PASS: {{ .Values.traggo.password }}
  TRAGGO_LOG_LEVEL: {{ .Values.traggo.log_level }}
{{- end }}
