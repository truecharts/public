{{/* Define the secret */}}
{{- define "readarr.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
{{- $readarr := .Values.readarr }}
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
  READARR__PORT: {{ .Values.service.main.ports.main.port | quote }}
  {{/* AUTH */}}
  {{- with $readarr.auth_method }}
  READARR__AUTHENTICATION_METHOD: {{ . }}
  {{- end }}

  {{/* DB */}}
  READARR__POSTGRES_PORT: "5432"
  READARR__POSTGRES_USER: {{ $dbuser }}
  READARR__POSTGRES_MAIN_DB: {{ $dbname }}

{{- end -}}
