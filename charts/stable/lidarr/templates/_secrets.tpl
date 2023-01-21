{{/* Define the secret */}}
{{- define "lidarr.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
{{- $lidarr := .Values.lidarr }}
{{- $dbuser := .Values.postgresql.postgresqlUsername }}
{{- $dbname := .Values.postgresql.postgresqlDatabase }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  LIDARR__PORT: {{ .Values.service.main.ports.main.port | quote }}
  {{/* AUTH */}}
  {{- with $lidarr.auth_method }}
  LIDARR__AUTHENTICATION_METHOD: {{ . }}
  {{- end }}

  {{/* DB */}}
  LIDARR__POSTGRES_PORT: "5432"
  LIDARR__POSTGRES_USER: {{ $dbuser }}
  LIDARR__POSTGRES_MAIN_DB: {{ $dbname }}

{{- end -}}
