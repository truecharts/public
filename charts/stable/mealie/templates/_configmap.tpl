{{/* Define the configmap */}}
{{- define "mealie.config" -}}

{{- $frontendConfigName := printf "%s-frontend-config" (include "tc.common.names.fullname" .) }}
{{- $apiConfigName := printf "%s-api-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $frontendConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  API_URL: http://localhost:{{ .Values.service.api.ports.api.targetPort }}
  {{/* https://github.com/hay-kot/mealie/issues/1666 */}}
  {{/* API_URL: http://localhost:{{ .Values.service.api.ports.api.port }} */}}
  THEME_LIGHT_PRIMARY: {{ .Values.mealie_frontend.theme.light_primary | default "#E58325" | quote }}
  THEME_LIGHT_ACCENT: {{ .Values.mealie_frontend.theme.light_accent | default "#007A99" | quote }}
  THEME_LIGHT_SECONDARY: {{ .Values.mealie_frontend.theme.light_secondary | default "#973542" | quote }}
  THEME_LIGHT_SUCCESS: {{ .Values.mealie_frontend.theme.light_success | default "#43A047" | quote }}
  THEME_LIGHT_INFO: {{ .Values.mealie_frontend.theme.light_info | default "#1976D2" | quote }}
  THEME_LIGHT_WARNING: {{ .Values.mealie_frontend.theme.light_warning | default "#FF6D00" | quote }}
  THEME_LIGHT_ERROR: {{ .Values.mealie_frontend.theme.light_error | default "#EF5350" | quote }}
  THEME_DARK_PRIMARY: {{ .Values.mealie_frontend.theme.dark_primary | default "#E58325" | quote }}
  THEME_DARK_ACCENT: {{ .Values.mealie_frontend.theme.dark_accent | default "#007A99" | quote }}
  THEME_DARK_SECONDARY: {{ .Values.mealie_frontend.theme.dark_secondary | default "#973542" | quote }}
  THEME_DARK_SUCCESS: {{ .Values.mealie_frontend.theme.dark_success | default "#43A047" | quote }}
  THEME_DARK_INFO: {{ .Values.mealie_frontend.theme.dark_info | default "#1976D2" | quote }}
  THEME_DARK_WARNING: {{ .Values.mealie_frontend.theme.dark_warning | default "#FF6D00" | quote }}
  THEME_DARK_ERROR: {{ .Values.mealie_frontend.theme.dark_error | default "#EF5350" | quote }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $apiConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PUID: {{ .Values.security.PUID | quote }}
  PGID: {{ .Values.podSecurityContext.fsGroup | quote }}
  TZ: {{ .Values.TZ }}
  DB_ENGINE: "postgres"
  POSTGRES_PORT: "5432"
  POSTGRES_USER: {{ .Values.postgresql.postgresqlUsername }}
  POSTGRES_DB: {{ .Values.postgresql.postgresqlDatabase }}
  POSTGRES_SERVER: {{ printf "%v-%v" .Release.Name "postgresql" }}
  API_PORT: {{ .Values.service.api.ports.api.targetPort | quote }}
  {{/* https://github.com/hay-kot/mealie/issues/1666 */}}
  {{/* API_PORT: {{ .Values.service.api.ports.api.port | quote }} */}}
  {{/* User Defined */}}
  {{/* General */}}
  ALLOW_SIGNUP: {{ .Values.mealie_backend.general.allow_signup | quote }}
  API_DOCS: "true"
  {{- with .Values.mealie_backend.general.default_group }}
  DEFAULT_GROUP: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.general.default_email }}
  DEFAULT_EMAIL: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.general.base_url }}
  BASE_URL: {{ . }}
  {{- end }}
  {{- if hasKey .Values.mealie_backend.general "token_time" }}
  {{- if or .Values.mealie_backend.general.token_time (eq 0 (int .Values.mealie_backend.general.token_time)) }}
  TOKEN_TIME: {{ .Values.mealie_backend.general.token_time | quote }}
  {{- end }}
  {{- end }}
  {{/* Security */}}
  {{- if hasKey .Values.mealie_backend.security "max_login_attempts" }}
  {{- if or .Values.mealie_backend.security.max_login_attempts (eq 0 (int .Values.mealie_backend.security.max_login_attempts)) }}
  SECURITY_MAX_LOGIN_ATTEMPTS: {{ .Values.mealie_backend.security.max_login_attempts | quote }}
  {{- end }}
  {{- end }}
  {{- if hasKey .Values.mealie_backend.security "user_lockout_time" }}
  {{- if or .Values.mealie_backend.security.user_lockout_time (eq 0 (int .Values.mealie_backend.security.user_lockout_time)) }}
  SECURITY_USER_LOCKOUT_TIME: {{ .Values.mealie_backend.security.user_lockout_time | quote }}
  {{- end }}
  {{- end }}
  {{/* Security */}}
  {{- if hasKey .Values.mealie_backend.webworkers "workers_per_core" }}
  {{- if or .Values.mealie_backend.webworkers.workers_per_core (eq 0 (int .Values.mealie_backend.webworkers.workers_per_core)) }}
  WORKERS_PER_CORE: {{ .Values.mealie_backend.webworkers.workers_per_core | quote }}
  {{- end }}
  {{- end }}
  {{- if hasKey .Values.mealie_backend.webworkers "max_workers" }}
  {{- if or .Values.mealie_backend.webworkers.max_workers (eq 0 (int .Values.mealie_backend.webworkers.max_workers)) }}
  MAX_WORKERS: {{ .Values.mealie_backend.webworkers.max_workers | quote }}
  {{- end }}
  {{- end }}
  {{- if hasKey .Values.mealie_backend.webworkers "web_concurrency" }}
  {{- if or .Values.mealie_backend.webworkers.web_concurrency (eq 0 (int .Values.mealie_backend.webworkers.web_concurrency)) }}
  WEB_CONCURRENCY: {{ .Values.mealie_backend.webworkers.web_concurrency | quote }}
  {{- end }}
  {{- end }}
  {{/* SMTP */}}
  {{- if hasKey .Values.mealie_backend.smtp "port" }}
  {{- if or .Values.mealie_backend.smtp.port (eq 0 (int .Values.mealie_backend.smtp.port)) }}
  SMTP_PORT: {{ .Values.mealie_backend.smtp.port | quote }}
  {{- end }}
  {{- end }}
  {{- with .Values.mealie_backend.smtp.host }}
  SMTP_HOST:  {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.smtp.from_name }}
  SMTP_FROM_NAME: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.smtp.auth_strategy }}
  SMTP_AUTH_STRATEGY: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.smtp.from_email }}
  SMTP_FROM_EMAIL: {{ . }}
  {{- end }}
  {{/* SMTP */}}
  LDAP_AUTH_ENABLED: {{ .Values.mealie_backend.ldap.auth_enabled | quote }}
  LDAP_TLS_INSECURE: {{ .Values.mealie_backend.ldap.tls_insecure | quote }}
  {{- with .Values.mealie_backend.ldap.server_url }}
  LDAP_SERVER_URL: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.ldap.tls_cacertfile }}
  LDAP_TLS_CACERTFILE: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.ldap.bind_template }}
  LDAP_BIND_TEMPLATE: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.ldap.base_dn }}
  LDAP_BASE_DN: {{ . }}
  {{- end }}
  {{- with .Values.mealie_backend.ldap.admin_filter }}
  LDAP_ADMIN_FILTER: {{ . }}
  {{- end }}
{{- end -}}
