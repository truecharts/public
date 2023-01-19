{{/* Define the secret */}}
{{- define "prowlarr.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
{{- $prowlarr := .Values.prowlarr }}
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
  PROWLARR__PORT: {{ .Values.service.main.ports.main.port | quote }}
  {{/* AUTH */}}
  {{- with $prowlarr.auth_method }}
  PROWLARR__AUTHENTICATION_METHOD: {{ . }}
  {{- end }}

  {{/* DB */}}
  PROWLARR__POSTGRES_PORT: 5432
  PROWLARR__POSTGRES_MAIN_DB: {{ $dbname }}
  PROWLARR__POSTGRES_USER: {{ $dbuser }}

{{- end -}}
