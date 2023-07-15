{{/* Define the secrets */}}
{{- define "mealie.secrets" -}}
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
{{- $fetchname := printf "%s-mealie-secrets" $basename -}}
{{- $api := .Values.mealie.api }}
{{- $frontend := .Values.mealie.frontend }}

enabled: true
data:

  {{/* Frontend */}}
  API_URL: http://localhost:{{ .Values.service.api.ports.api.port }}
  THEME_LIGHT_PRIMARY: {{ $frontend.theme.light_primary | default "#E58325" | quote }}
  THEME_LIGHT_ACCENT: {{ $frontend.theme.light_accent | default "#007A99" | quote }}
  THEME_LIGHT_SECONDARY: {{ $frontend.theme.light_secondary | default "#973542" | quote }}
  THEME_LIGHT_SUCCESS: {{ $frontend.theme.light_success | default "#43A047" | quote }}
  THEME_LIGHT_INFO: {{ $frontend.theme.light_info | default "#1976D2" | quote }}
  THEME_LIGHT_WARNING: {{ $frontend.theme.light_warning | default "#FF6D00" | quote }}
  THEME_LIGHT_ERROR: {{ $frontend.theme.light_error | default "#EF5350" | quote }}
  THEME_DARK_PRIMARY: {{ $frontend.theme.dark_primary | default "#E58325" | quote }}
  THEME_DARK_ACCENT: {{ $frontend.theme.dark_accent | default "#007A99" | quote }}
  THEME_DARK_SECONDARY: {{ $frontend.theme.dark_secondary | default "#973542" | quote }}
  THEME_DARK_SUCCESS: {{ $frontend.theme.dark_success | default "#43A047" | quote }}
  THEME_DARK_INFO: {{ $frontend.theme.dark_info | default "#1976D2" | quote }}
  THEME_DARK_WARNING: {{ $frontend.theme.dark_warning | default "#FF6D00" | quote }}
  THEME_DARK_ERROR: {{ $frontend.theme.dark_error | default "#EF5350" | quote }}

  {{/* API */}}
  DB_ENGINE: "postgres"
  POSTGRES_PORT: "5432"
  POSTGRES_USER: {{ .Values.cnpg.main.user }}
  POSTGRES_PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
  POSTGRES_DB: {{ .Values.cnpg.main.database }}
  POSTGRES_SERVER: {{ .Values.cnpg.main.creds.host }}
  API_PORT: {{ .Values.service.api.ports.api.port | quote }}
  {{/* User Defined */}}
  {{/* General */}}
  ALLOW_SIGNUP: {{ $api.general.allow_signup | quote }}
  API_DOCS: "true"
  {{- with $api.general.default_group }}
  DEFAULT_GROUP: {{ . }}
  {{- end }}
  {{- with $api.general.default_email }}
  DEFAULT_EMAIL: {{ . }}
  {{- end }}
  {{- with $api.general.base_url }}
  BASE_URL: {{ . }}
  {{- end }}
  {{- if hasKey $api.general "token_time" }}
  {{- if or $api.general.token_time (eq 0 (int $api.general.token_time)) }}
  TOKEN_TIME: {{ $api.general.token_time | quote }}
  {{- end }}
  {{- end }}
  {{/* Security */}}
  {{- if hasKey $api.security "max_login_attempts" }}
  {{- if or $api.security.max_login_attempts (eq 0 (int $api.security.max_login_attempts)) }}
  SECURITY_MAX_LOGIN_ATTEMPTS: {{ $api.security.max_login_attempts | quote }}
  {{- end }}
  {{- end }}
  {{- if hasKey $api.security "user_lockout_time" }}
  {{- if or $api.security.user_lockout_time (eq 0 (int $api.security.user_lockout_time)) }}
  SECURITY_USER_LOCKOUT_TIME: {{ $api.security.user_lockout_time | quote }}
  {{- end }}
  {{- end }}
  {{/* Security */}}
  {{- if hasKey $api.webworkers "workers_per_core" }}
  {{- if or $api.webworkers.workers_per_core (eq 0 (int $api.webworkers.workers_per_core)) }}
  WORKERS_PER_CORE: {{ $api.webworkers.workers_per_core | quote }}
  {{- end }}
  {{- end }}
  {{- if hasKey $api.webworkers "max_workers" }}
  {{- if or $api.webworkers.max_workers (eq 0 (int $api.webworkers.max_workers)) }}
  MAX_WORKERS: {{ $api.webworkers.max_workers | quote }}
  {{- end }}
  {{- end }}
  {{- if hasKey $api.webworkers "web_concurrency" }}
  {{- if or $api.webworkers.web_concurrency (eq 0 (int $api.webworkers.web_concurrency)) }}
  WEB_CONCURRENCY: {{ $api.webworkers.web_concurrency | quote }}
  {{- end }}
  {{- end }}
  {{/* SMTP */}}
  {{- if hasKey $api.smtp "port" }}
  {{- if or $api.smtp.port (eq 0 (int $api.smtp.port)) }}
  SMTP_PORT: {{ $api.smtp.port | quote }}
  {{- end }}
  {{- end }}
  {{- with $api.smtp.host }}
  SMTP_HOST:  {{ . }}
  {{- end }}
  {{- with $api.smtp.user | b64enc }}
  SMTP_USER: {{ . }}
  {{- end }}
  {{- with $api.smtp.password | b64enc }}
  SMTP_PASSWORD: {{ . }}
  {{- end }}
  {{- with $api.smtp.from_name }}
  SMTP_FROM_NAME: {{ . }}
  {{- end }}
  {{- with $api.smtp.auth_strategy }}
  SMTP_AUTH_STRATEGY: {{ . }}
  {{- end }}
  {{- with $api.smtp.from_email }}
  SMTP_FROM_EMAIL: {{ . }}
  {{- end }}
  {{/* SMTP */}}
  LDAP_AUTH_ENABLED: {{ $api.ldap.auth_enabled | quote }}
  LDAP_TLS_INSECURE: {{ $api.ldap.tls_insecure | quote }}
  {{- with $api.ldap.server_url }}
  LDAP_SERVER_URL: {{ . }}
  {{- end }}
  {{- with $api.ldap.tls_cacertfile }}
  LDAP_TLS_CACERTFILE: {{ . }}
  {{- end }}
  {{- with $api.ldap.bind_template }}
  LDAP_BIND_TEMPLATE: {{ . }}
  {{- end }}
  {{- with $api.ldap.base_dn }}
  LDAP_BASE_DN: {{ . }}
  {{- end }}
  {{- with $api.ldap.admin_filter }}
  LDAP_ADMIN_FILTER: {{ . }}
  {{- end }}
{{- end -}}
