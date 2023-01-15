{{/* Define the secret */}}
{{- define "prowlarr.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}
{{- $prowlarr := .Values.prowlarr }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{/* AUTH */}}
  {{- if $prowlarr.enable_external_auth }}
  PROWLARR__AUTHENTICATION_METHOD: "External"
  {{- end }}

  {{/* DB */}}
  PROWLARR__POSTGRES_HOST: {{ .Values.postgresql.url.complete | trimAll "\"" }}
  PROWLARR__POSTGRES_PORT: "5432"
  PROWLARR__POSTGRES_USER: {{ .Values.postgresql.postgresqlUsername | quote }}
  PROWLARR__POSTGRES_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  PROWLARR__POSTGRES_MAIN_DB: {{ .Values.postgresql.postgresqlDatabase }}
  PROWLARR__POSTGRES_LOG_DB: "prowlarr_log"

{{- end -}}
