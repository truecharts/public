{{/* Define the secret */}}
{{- define "sonarr.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
{{- $sonarr := .Values.sonarr }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  SONARR__PORT: {{ .Values.service.main.ports.main.port | quote }}
  {{/* AUTH */}}
  {{- with $sonarr.auth_method }}
  SONARR__AUTHENTICATION_METHOD: {{ . }}
  {{- end }}

  {{/* DB */}}
  {{- if .Values.postgresql.enabled }}
  SONARR__POSTGRES_HOST: {{ .Values.postgresql.url.plain | trimAll "\"" }}
  SONARR__POSTGRES_PORT: "5432"
  SONARR__POSTGRES_USER: {{ .Values.postgresql.postgresqlUsername }}
  SONARR__POSTGRES_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  SONARR__POSTGRES_MAIN_DB: {{ .Values.postgresql.postgresqlDatabase }}
  {{- end -}}

{{- end -}}
