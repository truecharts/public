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
  {{- with $prowlarr.auth_method }}
  PROWLARR__AUTHENTICATION_METHOD: {{ . }}
  {{- end }}

  {{/* DB */}}
  PROWLARR__POSTGRES_HOST: {{ .Values.postgresql.url.plain | trimAll "\"" }}
  PROWLARR__POSTGRES_PORT: "5432"
  PROWLARR__POSTGRES_USER: {{ .Values.postgresql.postgresqlUsername }}
  PROWLARR__POSTGRES_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  PROWLARR__POSTGRES_MAIN_DB: {{ .Values.postgresql.postgresqlDatabase }}

{{- end -}}
