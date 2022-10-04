{{/* Define the secret */}}
{{- define "docspell.secretbak" -}}

{{- $serverSecretName := printf "%s-server-secret" (include "tc.common.names.fullname" .) }}
{{- $joexSecretName := printf "%s-joex-secret" (include "tc.common.names.fullname" .) }}

{{ $server := .Values.rest_server }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $serverSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $serverSecretName) }}
  DOCSPELL_SERVER_AUTH_SERVER__SECRET: {{ index .data "DOCSPELL_SERVER_AUTH_SERVER__SECRET" }}
  {{- else }}
  {{/* This should ensure that container receivers something like b64:ENCODEDSECRET */}}
  DOCSPELL_SERVER_AUTH_SERVER__SECRET: {{ printf "b64:%v" (randAlphaNum 32 | b64enc) | b64enc }}
  {{- end }}

  {{/* This used to generate invitation keys via the WebUI or API */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $serverSecretName) }}
  DOCSPELL_SERVER_BACKEND_SIGNUP_NEW__INVITE__PASSWORD: {{ index .data "DOCSPELL_SERVER_BACKEND_SIGNUP_NEW__INVITE__PASSWORD" }}
  {{- else }}
  DOCSPELL_SERVER_BACKEND_SIGNUP_NEW__INVITE__PASSWORD: {{ randAlphaNum 32 | b64enc }}
  {{- end }}

  DOCSPELL_SERVER_BACKEND_JDBC_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}

  {{- with $server.admin_endpoint.secret }}
  DOCSPELL_SERVER_ADMIN__ENDPOINT_SECRET: {{ . | b64enc }}
  {{- end }}

  {{- with $server.integration_endpoint.http_basic_auth.password }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__BASIC_PASSWORD: {{ . | b64enc }}
  {{- end }}

  {{- with $server.integration_endpoint.http_header.header_name }}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__HEADER_HEADER__VALUE: {{ . | b64enc }}
  {{- end }}

  {{- with $server.backend.files.stores.minio.access_key }}
  DOCSPELL_SERVER_BACKEND_FILES_STORES_MINIO_ACCESS__KEY: {{ . | b64enc }}
  {{- end }}

  {{- with $server.backend.files.stores.minio.secret_key }}
  DOCSPELL_SERVER_BACKEND_FILES_STORES_MINIO_SECRET__KEY: {{ . | b64enc }}
  {{- end }}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $joexSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DOCSPELL_JOEX_JDBC_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
{{- end }}
