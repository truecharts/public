{{/* Define the secret */}}
{{- define "radarr.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
{{- $radarr := .Values.radarr }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  RADARR__PORT: {{ .Values.service.main.ports.main.port | quote }}
  {{/* AUTH */}}
  {{- with $radarr.auth_method }}
  RADARR__AUTHENTICATION_METHOD: {{ . }}
  {{- end }}

  {{/* DB */}}
  RADARR__POSTGRES_HOST: {{ .Values.postgresql.url.plain | trimAll "\"" }}
  RADARR__POSTGRES_PORT: "5432"
  RADARR__POSTGRES_USER: {{ .Values.postgresql.postgresqlUsername }}
  RADARR__POSTGRES_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  RADARR__POSTGRES_MAIN_DB: {{ .Values.postgresql.postgresqlDatabase }}

{{- end -}}
