{{/* Define the secret */}}
{{- define "traggo.secret" -}}

enabled: true
data:
  TRAGGO_DATABASE_DIALECT: sqlite3
  TRAGGO_DATABASE_CONNECTION: /opt/traggo/data/traggo.db
  TRAGGO_PORT: {{ .Values.service.main.ports.main.port | quote }}
  TRAGGO_PASS_STRENGTH: {{ .Values.traggo.pass_strength | quote }}
  TRAGGO_DEFAULT_USER_NAME: {{ .Values.traggo.username }}
  TRAGGO_DEFAULT_USER_PASS: {{ .Values.traggo.password }}
  TRAGGO_LOG_LEVEL: {{ .Values.traggo.log_level }}
{{- end }}
