{{/* Define the secrets */}}
{{- define "mealie.secrets" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}
{{- $mealie := .Values.mealie }}

mealie:
  enabled: true
  data:
    {{/* mealie */}}
    THEME_LIGHT_PRIMARY: {{ $mealie.theme.light_primary | default "#E58325" | quote }}
    THEME_LIGHT_ACCENT: {{ $mealie.theme.light_accent | default "#007A99" | quote }}
    THEME_LIGHT_SECONDARY: {{ $mealie.theme.light_secondary | default "#973542" | quote }}
    THEME_LIGHT_SUCCESS: {{ $mealie.theme.light_success | default "#43A047" | quote }}
    THEME_LIGHT_INFO: {{ $mealie.theme.light_info | default "#1976D2" | quote }}
    THEME_LIGHT_WARNING: {{ $mealie.theme.light_warning | default "#FF6D00" | quote }}
    THEME_LIGHT_ERROR: {{ $mealie.theme.light_error | default "#EF5350" | quote }}
    THEME_DARK_PRIMARY: {{ $mealie.theme.dark_primary | default "#E58325" | quote }}
    THEME_DARK_ACCENT: {{ $mealie.theme.dark_accent | default "#007A99" | quote }}
    THEME_DARK_SECONDARY: {{ $mealie.theme.dark_secondary | default "#973542" | quote }}
    THEME_DARK_SUCCESS: {{ $mealie.theme.dark_success | default "#43A047" | quote }}
    THEME_DARK_INFO: {{ $mealie.theme.dark_info | default "#1976D2" | quote }}
    THEME_DARK_WARNING: {{ $mealie.theme.dark_warning | default "#FF6D00" | quote }}
    THEME_DARK_ERROR: {{ $mealie.theme.dark_error | default "#EF5350" | quote }}
    {{/* Database */}}
    DB_ENGINE: "postgres"
    POSTGRES_PORT: "5432"
    POSTGRES_USER: {{ .Values.cnpg.main.user }}
    POSTGRES_PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
    POSTGRES_DB: {{ .Values.cnpg.main.database }}
    POSTGRES_SERVER: {{ .Values.cnpg.main.creds.host }}
    {{/* User Defined */}}
    {{/* General */}}
    ALLOW_SIGNUP: {{ $mealie.general.allow_signup | quote }}
    DEFAULT_GROUP: {{ $mealie.general.default_group }}
    DEFAULT_EMAIL: {{ $mealie.general.default_email }}
    BASE_URL: {{ $mealie.general.base_url }}
    TOKEN_TIME: {{ $mealie.general.token_time | quote }}
    {{/* Security */}}
    SECURITY_MAX_LOGIN_ATTEMPTS: {{ $mealie.security.max_login_attempts | quote }}
    SECURITY_USER_LOCKOUT_TIME: {{ $mealie.security.user_lockout_time | quote }}
    {{/* SMTP */}}
  {{- if $mealie.smtp.host }}
    SMTP_PORT: {{ $mealie.smtp.port | quote }}
    SMTP_HOST: {{ $mealie.smtp.host | quote }}
    SMTP_USER: {{ $mealie.smtp.user | quote }}
    SMTP_PASSWORD: {{ $mealie.smtp.password | quote }}
    SMTP_FROM_NAME: {{ $mealie.smtp.from_name | quote }}
    SMTP_AUTH_STRATEGY: {{ $mealie.smtp.auth_strategy | quote }}
    SMTP_FROM_EMAIL: {{ $mealie.smtp.from_email | quote }}
  {{- end }}
    {{/* Workers */}}
    WORKERS_PER_CORE: {{ $mealie.webworkers.workers_per_core | quote }}
    MAX_WORKERS: {{ $mealie.webworkers.max_workers | quote }}
    WEB_CONCURRENCY: {{ $mealie.webworkers.web_concurrency | quote }}
    {{/* LDAP */}}
  {{- if $mealie.ldap.auth_enabled }}
    LDAP_AUTH_ENABLED: {{ $mealie.ldap.auth_enabled | quote }}
    {{- with $mealie.ldap.server_url }}
    LDAP_SERVER_URL: {{ . }}
    {{- end }}
    LDAP_TLS_INSECURE: {{ $mealie.ldap.tls_insecure | quote }}
    LDAP_ENABLE_STARTTLS: {{ $mealie.ldap.enable_starttls | quote }}
    {{- with $mealie.ldap.tls_cacertfile }}
    LDAP_TLS_CACERTFILE: {{ . | quote }}
    {{- end -}}
    {{- with $mealie.ldap.base_dn }}
    LDAP_BASE_DN: {{ . | quote }}
    {{- end -}}
    {{- with $mealie.ldap.query_bind }}
    LDAP_QUERY_BIND: {{ . | quote }}
    {{- end -}}
    {{- with $mealie.ldap.query_password }}
    LDAP_QUERY_PASSWORD: {{ . | quote }}
    {{- end -}}
    {{- with $mealie.ldap.user_filter }}
    LDAP_USER_FILTER: {{ . | quote }}
    {{- end -}}
    {{- with $mealie.ldap.admin_filter }}
    LDAP_ADMIN_FILTER: {{ . | quote }}
    {{- end -}}
    {{- with $mealie.ldap.id_attribute }}
    LDAP_ID_ATTRIBUTE: {{ . | quote }}
    {{- end -}}
    {{- with $mealie.ldap.name_attribute }}
    LDAP_NAME_ATTRIBUTE: {{ . | quote }}
    {{- end -}}
    {{- with $mealie.ldap.mail_attribute }}
    LDAP_MAIL_ATTRIBUTE: {{ . | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}
