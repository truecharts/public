{{/* Define the secret */}}
{{- define "penpot.secret" -}}

{{- $secretName := printf "%s-common-secret" (include "tc.common.names.fullname" .) }}
{{- $exporterSecretName := printf "%s-exporter-secret" (include "tc.common.names.fullname" .) }}
{{- $backendSecretName := printf "%s-backend-secret" (include "tc.common.names.fullname" .) }}
{{- $frontendSecretName := printf "%s-frontend-secret" (include "tc.common.names.fullname" .) }}

---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{/* Dependencies */}}
  PENPOT_DATABASE_URI: {{ printf "postgresql://%v/%v" .Values.postgresql.url.plainport .Values.postgresql.postgresqlDatabase }}
  PENPOT_DATABASE_USERNAME: {{ .Values.postgresql.postgresqlUsername }}
  PENPOT_DATABASE_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}
  PENPOT_REDIS_URI: {{ printf "redis://%v:%v@%v/%v" "default" (.Values.redis.redisPassword | trimAll "\"") .Values.redis.url.plainport "0" }}
  {{/* Penpot */}}
  PENPOT_STORAGE_ASSETS_FS_DIRECTORY: {{ .Values.persistence.assets.mountPath }}
  PENPOT_ASSETS_STORAGE_BACKEND: assets-fs
  PENPOT_HTTP_SERVER_HOST: "0.0.0.0"
  {{- with .Values.penpot.flags }}
  PENPOT_FLAGS: {{ join " " . | quote }}
  {{- end }}
  PENPOT_TELEMETRY_ENABLED: {{ .Values.penpot.telemetry_enabled | quote }}
  {{- with .Values.penpot.registration_domain_whitelist }}
  PENPOT_REGISTRATION_DOMAIN_WHITELIST: {{ join "," . }}
  {{- end }}
  {{- if .Values.penpot.smtp.enabled }}
  PENPOT_SMTP_DEFAULT_FROM: {{ .Values.penpot.smtp.default_from | quote }}
  PENPOT_SMTP_DEFAULT_REPLY_TO: {{ .Values.penpot.smtp.default_reply_to | quote }}
  PENPOT_SMTP_HOST: {{ .Values.penpot.smtp.host | quote }}
  PENPOT_SMTP_PORT: {{ .Values.penpot.smtp.port | quote }}
  PENPOT_SMTP_USERNAME: {{ .Values.penpot.smtp.user | quote }}
  PENPOT_SMTP_PASSWORD: {{ .Values.penpot.smtp.pass | quote }}
  PENPOT_SMTP_TLS: {{ .Values.penpot.smtp.tls | quote }}
  PENPOT_SMTP_SSL: {{ .Values.penpot.smtp.ssl | quote }}
  {{- end }}
  {{- if .Values.penpot.identity_providers.google.enabled }}
  PENPOT_GOOGLE_CLIENT_ID: {{ .Values.penpot.identity_providers.google.client_id | quote }}
  PENPOT_GOOGLE_CLIENT_SECRET: {{ .Values.penpot.identity_providers.google.client_secret | quote }}
  {{- end }}
  {{- if .Values.penpot.identity_providers.github.enabled }}
  PENPOT_GITHUB_CLIENT_ID: {{ .Values.penpot.identity_providers.github.client_id | quote }}
  PENPOT_GITHUB_CLIENT_ID: {{ .Values.penpot.identity_providers.github.client_secret | quote }}
  {{- end }}
  {{- if .Values.penpot.identity_providers.gitlab.enabled }}
  PENPOT_GITLAB_BASE_URI: {{ .Values.penpot.identity_providers.gitlab.base_uri | quote }}
  PENPOT_GITLAB_CLIENT_ID: {{ .Values.penpot.identity_providers.gitlab.client_id | quote }}
  PENPOT_GITLAB_CLIENT_SECRET: {{ .Values.penpot.identity_providers.gitlab.client_secret | quote }}
  {{- end }}
  {{- if .Values.penpot.identity_providers.oidc.enabled }}
  PENPOT_OIDC_BASE_URI: {{ .Values.penpot.identity_providers.oidc.base_uri | quote }}
  PENPOT_OIDC_CLIENT_ID: {{ .Values.penpot.identity_providers.oidc.client_id | quote }}
  PENPOT_OIDC_CLIENT_SECRET: {{ .Values.penpot.identity_providers.oidc.client_secret | quote }}
  {{- end }}
  {{- if .Values.penpot.identity_providers.ldap.enabled }}
  PENPOT_LDAP_HOST: {{ .Values.penpot.identity_providers.ldap.host | quote }}
  PENPOT_LDAP_PORT: {{ .Values.penpot.identity_providers.ldap.port | quote }}
  PENPOT_LDAP_SSL: {{ .Values.penpot.identity_providers.ldap.ssl | quote }}
  PENPOT_LDAP_STARTTLS: {{ .Values.penpot.identity_providers.ldap.starttls | quote }}
  PENPOT_LDAP_BASE_DN: {{ .Values.penpot.identity_providers.ldap.base_dn | quote }}
  PENPOT_LDAP_BIND_DN: {{ .Values.penpot.identity_providers.ldap.bind_dn | quote }}
  PENPOT_LDAP_BIND_PASSWORD: {{ .Values.penpot.identity_providers.ldap.bind_pass | quote }}
  PENPOT_LDAP_ATTRS_USERNAME: {{ .Values.penpot.identity_providers.ldap.attrs_username | quote }}
  PENPOT_LDAP_ATTRS_EMAIL: {{ .Values.penpot.identity_providers.ldap.attrs_email | quote }}
  PENPOT_LDAP_ATTRS_FULLNAME: {{ .Values.penpot.identity_providers.ldap.attrs_fullname | quote }}
  {{- end }}

---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $exporterSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{/* Is for exporter, to communicate with frontend.
  I know, PUBLIC doesn't make much sense */}}
  PENPOT_PUBLIC_URI: http://localhost:{{ .Values.service.main.ports.main.targetPort }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $backendSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  PENPOT_PUBLIC_URI: {{ .Values.penpot.public_uri | quote }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $frontendSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  PENPOT_PUBLIC_URI: {{ .Values.penpot.public_uri | quote }}
{{- end }}
