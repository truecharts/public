{{/* Define the secret */}}
{{- define "gotify.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

{{ $url := ( .Values.postgresql.url.plain | trimAll "\"" ) }}
{{ $password := ( .Values.postgresql.postgresqlPassword | trimAll "\"" ) }}

---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  GOTIFY_SERVER_PORT: {{ .Values.service.main.ports.main.port }}

  {{/* Auth */}}
  GOTIFY_DEFAULTUSER_NAME: {{ .Values.gotify.user }}
  GOTIFY_DEFAULTUSER_PASS: {{ .Values.gotify.pass }}

  GOTIFY_REGISTRATION: {{ .Values.gotify.registration }}
  GOTIFY_SERVER_KEEPALIVEPERIODSECONDS: {{ .Values.gotify.keep_alive_period_seconds }}
  GOTIFY_SERVER_LISTENADDR: {{ .Values.gotify.listen_address }}
  GOTIFY_SERVER_SSL_ENABLED: {{ .Values.gotify.ssl_enabled }}
  GOTIFY_SERVER_RESPONSEHEADERS: {{ .Values.gotify.response_headers }}
  GOTIFY_SERVER_STREAM_PINGPERIODSECONDS: {{ .Values.gotify.stream_period_seconds }}
  GOTIFY_PASSSTRENGTH: {{ .Values.gotify.password_strength }}

  {{/* Dirs */}}
  GOTIFY_UPLOADEDIMAGESDIR: "data/images"
  GOTIFY_PLUGINSDIR: "data/plugins"

  {{/* Database */}}
  GOTIFY_DATABASE_CONNECTION: "host={{ $url }} port=5432 user={{ .Values.postgresql.postgresqlUsername }} dbname={{ .Values.postgresql.postgresqlDatabase }} password={{ $password }} sslmode=disable"
  GOTIFY_DATABASE_DIALECT: "postgres"
{{- end -}}
