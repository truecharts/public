{{/* Define the secrets */}}
{{- define "mealie.secrets" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}
{{- $api := .Values.mealie.api -}}
{{- $frontend := .Values.mealie.frontend }}

frontend:
  enabled: true
  data:
    {{/* Frontend */}}
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

api:
  enabled: true
  data:
    API_PORT: {{ .Values.service.main.ports.main.port | quote }}
    {{/* Database */}}
    DB_ENGINE: "postgres"
    POSTGRES_PORT: "5432"
    POSTGRES_USER: {{ .Values.cnpg.main.user }}
    POSTGRES_PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
    POSTGRES_DB: {{ .Values.cnpg.main.database }}
    POSTGRES_SERVER: {{ .Values.cnpg.main.creds.host }}
    {{/* User Defined */}}
    {{/* General */}}
    ALLOW_SIGNUP: {{ $api.general.allow_signup | quote }}
    DEFAULT_GROUP: {{ $api.general.default_group }}
    DEFAULT_EMAIL: {{ $api.general.default_email }}
    BASE_URL: {{ $api.general.base_url }}
    TOKEN_TIME: {{ $api.general.token_time | quote }}
    {{/* Security */}}
    SECURITY_MAX_LOGIN_ATTEMPTS: {{ $api.security.max_login_attempts | quote }}
    SECURITY_USER_LOCKOUT_TIME: {{ $api.security.user_lockout_time | quote }}
    {{/* SMTP */}}
  {{- if $api.smtp.host }}
    SMTP_PORT: {{ $api.smtp.port | quote }}
    SMTP_HOST: {{ $api.smtp.host | quote }}
    SMTP_USER: {{ $api.smtp.user | quote }}
    SMTP_PASSWORD: {{ $api.smtp.password | quote }}
    SMTP_FROM_NAME: {{ $api.smtp.from_name | quote }}
    SMTP_AUTH_STRATEGY: {{ $api.smtp.auth_strategy | quote }}
    SMTP_FROM_EMAIL: {{ $api.smtp.from_email | quote }}
  {{- end }}
    {{/* Workers */}}
    WORKERS_PER_CORE: {{ $api.webworkers.workers_per_core | quote }}
    MAX_WORKERS: {{ $api.webworkers.max_workers | quote }}
    WEB_CONCURRENCY: {{ $api.webworkers.web_concurrency | quote }}
    {{/* LDAP */}}
  {{- if $api.ldap.auth_enabled }}
    LDAP_AUTH_ENABLED: {{ $api.ldap.auth_enabled | quote }}
    {{- with $api.ldap.server_url }}
    LDAP_SERVER_URL: {{ . }}
    {{- end }}
    LDAP_TLS_INSECURE: {{ $api.ldap.tls_insecure | quote }}
    LDAP_ENABLE_STARTTLS: {{ $api.ldap.enable_starttls | quote }}
    {{- with $api.ldap.tls_cacertfile }}
    LDAP_TLS_CACERTFILE: {{ . | quote }}
    {{- end -}}
    {{- with $api.ldap.base_dn }}
    LDAP_BASE_DN: {{ . | quote }}
    {{- end -}}
    {{- with $api.ldap.query_bind }}
    LDAP_QUERY_BIND: {{ . | quote }}
    {{- end -}}
    {{- with $api.ldap.query_password }}
    LDAP_QUERY_PASSWORD: {{ . | quote }}
    {{- end -}}
    {{- with $api.ldap.user_filter }}
    LDAP_USER_FILTER: {{ . | quote }}
    {{- end -}}
    {{- with $api.ldap.admin_filter }}
    LDAP_ADMIN_FILTER: {{ . | quote }}
    {{- end -}}
    {{- with $api.ldap.id_attribute }}
    LDAP_ID_ATTRIBUTE: {{ . | quote }}
    {{- end -}}
    {{- with $api.ldap.name_attribute }}
    LDAP_NAME_ATTRIBUTE: {{ . | quote }}
    {{- end -}}
    {{- with $api.ldap.mail_attribute }}
    LDAP_MAIL_ATTRIBUTE: {{ . | quote }}
    {{- end -}}
    {{- with $api.oidc.auth_enabled }}
    OIDC_AUTH_ENABLED: {{ . | quote }}
    {{- end -}}
    {{- with $api.oidc.signup_enabled }}
    OIDC_SIGNUP_ENABLED: {{ . | quote }}
    {{- end -}}
    {{- with $api.oidc.configuration_url }}
    OIDC_CONFIGURATION_URL: {{ . | quote }}
    {{- end -}}
    {{- with $api.oidc.client_id }}
    OIDC_CLIENT_ID: {{ . | quote }}
    {{- end -}}
    {{- with $api.oidc.user_group }}
    OIDC_USER_GROUP: {{ . | quote }}
    {{- end -}}
    {{- with $api.oidc.admin_group }}
    OIDC_ADMIN_GROUP: {{ . | quote }}
    {{- end -}}
    {{- with $api.oidc.auto_redirect }}
    OIDC_AUTO_REDIRECT: {{ . | quote }}
    {{- end -}}
    {{- with $api.oidc.provider_name }}
    OIDC_PROVIDER_NAME: {{ . | quote }}
    {{- end -}}
    {{- with $api.oidc.remember_me }}
    OIDC_REMEMBER_ME: {{ . | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}
