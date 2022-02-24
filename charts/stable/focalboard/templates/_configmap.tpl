{{- define "focalboard.configmap" -}}

{{- $pgPass := .Values.postgresql.postgresqlPassword | trimAll "\"" }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-install
  labels:
    {{- include "common.labels" . | nindent 4 }}
data:
  focalboard-config: |-
    {
      "serverRoot": "{{ .Values.focalboard.serverRoot }}",
      "port": {{ .Values.service.main.ports.main.port }},
      "dbtype": "postgres",
      "dbconfig": "{{ printf "postgresql://%v:%v@%v-postgresql:5432/%v" .Values.postgresql.postgresqlUsername $pgPass .Release.Name .Values.postgresql.postgresqlDatabase }}",
      "postgres_dbconfig": "dbname={{ .Values.postgresql.postgresqlDatabase }} sslmode=disable",
      "useSSL": false,
      "webpath": "./pack",
      "filespath": "/uploads",
      "telemetry": {{ .Values.focalboard.telemetry }},
      "session_expire_time": 2592000,
      "session_refresh_time": 18000,
      "localOnly": {{ .Values.focalboard.localOnly }},
      "enableLocalMode": {{ .Values.focalboard.enableLocalMode }},
      "localModeSocketLocation": "/var/tmp/focalboard_local.socket"
    }
{{- end -}}
