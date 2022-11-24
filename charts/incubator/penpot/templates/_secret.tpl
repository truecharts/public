{{/* Define the secret */}}
{{- define "penpot.secret" -}}

{{- $secretName := printf "%s-penpot-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  PENPOT_PUBLIC_URI: {{ .Values.penpot.public_uri | quote }}
  {{- with .Values.penpot.flags }}
  PENPOT_FLAGS: {{ join " " . }}
  {{- end }}
  PENPOT_HTTP_SERVER_HOST: {{ .Values.penpot.http_server_host | quote }}
  PENPOT_DATABASE_URI: {{ .Values.postgresql.url.complete | quote }}
  PENPOT_DATABASE_USERNAME: {{ .Values.postgresql.postgresqlUsername }}
  PENPOT_DATABASE_PASSWORD: {{ .Values.penpot.db_pass | quote }}
  PENPOT_REDIS_URI: {{ .Values.redis.url.complete | quote }}
  PENPOT_ASSETS_STORAGE_BACKEND: {{ .Values.penpot.assets_storage_backend | quote }}
  PENPOT_STORAGE_ASSETS_FS_DIRECTORY: {{ .Values.penpot.assets_storage_assets_fs_directory | quote }}
  PENPOT_TELEMETRY_ENABLED: {{ .Values.penpot.telemetry_enabled | quote }}
  {{- with .Values.penpot.registration_domain_whitelist }}
  PENPOT_REGISTRATION_DOMAIN_WHITELIST: {{ join "," . }}
  {{- end }}
  {{- if .Values.notifier.smtp.enabled }}
  PENPOT_SMTP_DEFAULT_FROM: {{ .Values.notifier.smtp.default_from | quote }}
  PENPOT_SMTP_DEFAULT_REPLY_TO: {{ .Values.notifier.smtp.default_reply_to | quote }}
  PENPOT_SMTP_HOST: {{ .Values.notifier.smtp.host | quote }}
  PENPOT_SMTP_PORT: {{ .Values.notifier.smtp.port | quote }}
  PENPOT_SMTP_USERNAME: {{ .Values.notifier.smtp.user | quote }}
  PENPOT_SMTP_PASSWORD: {{ .Values.notifier.smtp.pass | quote }}
  PENPOT_SMTP_TLS: {{ .Values.notifier.smtp.tls | quote }}
  PENPOT_SMTP_SSL: {{ .Values.notifier.smtp.ssl | quote }}
  {{- end }}
  {{- if .Values.identity_providers.google.enabled }}
  PENPOT_GOOGLE_CLIENT_ID: {{ .Values.identity_providers.google.client_id | quote }}
  PENPOT_GOOGLE_CLIENT_SECRET: {{ .Values.identity_providers.google.client_secret | quote }}
  {{- end }}
  {{- if .Values.identity_providers.github.enabled }}
  PENPOT_GITHUB_CLIENT_ID: {{ .Values.identity_providers.github.client_id | quote }}
  PENPOT_GITHUB_CLIENT_ID: {{ .Values.identity_providers.github.client_secret | quote }}
  {{- end }}
  {{- if .Values.identity_providers.gitlab.enabled }}
  PENPOT_GITLAB_BASE_URI: {{ .Values.identity_providers.gitlab.base_uri | quote }}
  PENPOT_GITLAB_CLIENT_ID: {{ .Values.identity_providers.gitlab.client_id | quote }}
  PENPOT_GITLAB_CLIENT_SECRET: {{ .Values.identity_providers.gitlab.client_secret | quote }}
  {{- end }}
  {{- if .Values.identity_providers.odic.enabled }}
  PENPOT_OIDC_BASE_URI: {{ .Values.identity_providers.odic.base_uri | quote }}
  PENPOT_OIDC_CLIENT_ID: {{ .Values.identity_providers.odic.client_id | quote }}
  PENPOT_OIDC_CLIENT_SECRET: {{ .Values.identity_providers.odic.client_secret | quote }}
  {{- end }}
  {{- if .Values.identity_providers.ldap.enabled }}
  PENPOT_LDAP_HOST: {{ .Values.identity_providers.ldap.host | quote }}
  PENPOT_LDAP_PORT: {{ .Values.identity_providers.ldap.port | quote }}
  PENPOT_LDAP_SSL: {{ .Values.identity_providers.ldap.ssl | quote }}
  PENPOT_LDAP_STARTTLS: {{ .Values.identity_providers.ldap.starttls | quote }}
  PENPOT_LDAP_BASE_DN: {{ .Values.identity_providers.ldap.base_dn | quote }}
  PENPOT_LDAP_BIND_DN: {{ .Values.identity_providers.ldap.bind_dn | quote }}
  PENPOT_LDAP_BIND_PASSWORD: {{ .Values.identity_providers.ldap.bind_pass | quote }}
  PENPOT_LDAP_ATTRS_USERNAME: {{ .Values.identity_providers.ldap.attrs_username | quote }}
  PENPOT_LDAP_ATTRS_EMAIL: {{ .Values.identity_providers.ldap.attrs_email | quote }}
  PENPOT_LDAP_ATTRS_FULLNAME: {{ .Values.identity_providers.ldap.attrs_fullname | quote }}
  {{- end }}
{{- end }}
