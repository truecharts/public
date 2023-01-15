{{/* Define the secret */}}
{{- define "lidarr.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
{{- $lidarr := .Values.lidarr }}
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
  LIDARR__POSTGRES_HOST: {{ .Values.postgresql.url.plain | trimAll "\"" }}
  LIDARR__POSTGRES_PORT: "5432"
  LIDARR__POSTGRES_USER: {{ .Values.postgresql.postgresqlUsername }}
  LIDARR__POSTGRES_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  LIDARR__POSTGRES_MAIN_DB: {{ .Values.postgresql.postgresqlDatabase }}

{{- end -}}
