{{/* Define the secret */}}
{{- define "netbox.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

{{- $secret_key := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  {{- $secret_key = (index .data "secret_key") }}
{{- else }}
  {{- $secret_key = randAlphaNum 64 }}
{{- end }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  secret_key: {{ $secret_key | b64enc }}
stringData:
  config.py: |
    ALLOWED_HOSTS = [
        {{- range .Values.netbox.allowed_hosts }}
        {{ . | squote }},
        {{- end }}
    ]

    DATABASE = {
        'NAME': '{{ .Values.postgresql.postgresqlDatabase }}',
        'USER': '{{ .Values.postgresql.postgresqlUsername }}',
        'PASSWORD': '{{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}',
        'HOST': '{{ printf "%v-%v" .Release.Name "postgresql" }}',
        'PORT': '5432',
        'CONN_MAX_AGE': '300',
    }

    REDIS = {
        'tasks': {
            'HOST': 'redis://:{{ printf "%v-%v" .Release.Name "redis" }}',
            'PORT': 6379,
            'PASSWORD': '{{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}',
            'DATABASE': 0,
            'SSL': False,
          },
          'caching': {
            'HOST': 'redis://:{{ printf "%v-%v" .Release.Name "redis" }}',
            'PORT': 6379,
            'PASSWORD': '{{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}',
            'DATABASE': 1,
            'SSL': False,
          }
    }

    SECRET_KEY = '{{ $secret_key }}'

    {{- with .Values.netbox.admins }}
    ADMINS = [
        {{- range . }}
        ({{ .name | squote }},{{ .email | squote }}),
        {{- end }}
    ]
    {{- end }}

    {{- with .Values.netbox.auth_password_validators }}
    AUTH_PASSWORD_VALIDATORS = [
        {{- range . }}
        {
            'NAME': {{ .name | squote }},
            'OPTIONS': {
                {{- range .options }}
                {{ .key | squote }}: {{ .value }},
                {{- end }}
            }

        },
        {{- end }}
    ]
    {{- end }}

    CORS_ORIGIN_ALLOW_ALL = {{ ternary "True" "False" .Values.netbox.cors_origin_allow_all }}

    {{- with .Values.netbox.cors_origin_whitelist }}
    CORS_ORIGIN_WHITELIST = [
        {{- range . }}
        {{ . | squote }},
        {{- end }}
    ]
    {{- end }}

    {{- with .Values.netbox.cors_origin_regex_whitelist }}
    CORS_ORIGIN_REGEX_WHITELIST = [
        {{- range . }}
        {{ . }},
        {{- end }}
    ]
    {{- end }}

    DEBUG = {{ ternary "True" "False" .Values.netbox.debug }}

    {{- if .Values.netbox.email }}
    {{- if .Values.netbox.email.server }}
    EMAIL = {
        {{- with .Values.netbox.email.server }}
        'SERVER': {{ . | squote }},
        {{- end }}
        {{- with .Values.netbox.email.port }}
        'PORT': {{ . }},
        {{- end }}
        {{- with .Values.netbox.email.username }}
        'USERNAME': {{ . | squote }},
        {{- end }}
        {{- with .Values.netbox.email.password }}
        'PASSWORD': {{ . | squote }},
        {{- end }}
        'USE_SSL': {{ ternary "True" "False" .Values.netbox.email.use_ssl }},
        'USE_TLS': {{ ternary "True" "False" .Values.netbox.email.use_tls }},
        {{- with .Values.netbox.email.timeout }}
        'TIMEOUT': {{ . }},
        {{- end }}
        {{- with .Values.netbox.email.from_email }}
        'FROM_EMAIL': {{ . | squote }},
        {{- end }}
    }
    {{- end }}
    {{- end }}

    {{- with .Values.netbox.exempt_view_permissions }}
    EXEMPT_VIEW_PERMISSIONS = [
        {{- range . }}
        {{ . | squote }},
        {{- end }}
    ]
    {{- end }}

    {{- with .Values.netbox.http_proxies }}
    HTTP_PROXIES = {
        {{- range . }}
        {{ .key | squote }}: {{ .url | squote }},
        {{- end }}
    }
    {{- end }}

    {{- with .Values.netbox.internal_ips }}
    INTERNAL_IPS = (
        {{- range . }}
        {{ . | squote }},
        {{- end }}
    )
    {{- end }}

    {{- with .Values.netbox.logging }}
    LOGGING = {
        {{- range . }}
        {{- end }}
    }
    {{- end }}

    LOGIN_PERSISTENCE = {{ ternary "True" "False" .Values.netbox.login_persistence }}

    LOGIN_REQUIRED = {{ ternary "True" "False" .Values.netbox.login_required }}

    {{- with .Values.netbox.login_timeout }}
    LOGIN_TIMEOUT = {{ . }}
    {{- end }}

    METRICS_ENABLED = {{ ternary "True" "False" .Values.netbox.metrics }}

    TIME_ZONE = {{ .Values.TZ | squote }}

    MEDIA_ROOT = '/opt/netbox/netbox/media'
    REPORTS_ROOT = '/opt/netbox/netbox/reports'
    SCRIPTS_ROOT = '/opt/netbox/netbox/scripts'

    {{- with .Values.netbox.storage_backend }}
    STORAGE_BACKEND = {{ . | squote }}
    {{- end }}

    {{- with .Values.netbox.storage_config }}
    STORAGE_CONFIG = {
        {{- range . }}
        {{ .key | squote }}: {{ .value | squote }},
        {{- end }}
    }
    {{- end }}

    {{- with .Values.netbox.plugins }}
    PLUGINS = [
        {{- range . }}
        {{ . | squote }},
        {{- end }}
    ]
    {{- end }}

    {{- with .Values.netbox.plugin_config }}
    PLUGINS_CONFIG = {
        {{- range . }}
        {{ .plugin_name | squote }}: {
            {{- range .config }}
            {{ .key | squote }}: {{ .value | squote }},
            {{- end }}
        }
        {{- end }}
    }
    {{- end }}

    {{- with .Values.netbox.rq_default_timeout }}
    RQ_DEFAULT_TIMEOUT = {{ . }}
    {{- end }}

    {{- with .Values.netbox.session_cookie_name }}
    SESSION_COOKIE_NAME = {{ . | squote }}
    {{- end }}

    {{- with .Values.netbox.csrf_cookie_name }}
    CSRF_COOKIE_NAME = {{ . | squote }}
    {{- end }}

    RELEASE_CHECK_URL = 'https://api.github.com/repos/netbox-community/netbox/releases'

    {{- with .Values.netbox.remote_auth }}
    {{- if .enabled }}
    REMOTE_AUTH_ENABLED = True
    {{- with .backend }}
    REMOTE_AUTH_BACKEND = {{ . | squote }}
    {{- end }}
    {{- with .header }}
    REMOTE_AUTH_HEADER = {{ . | squote }}
    {{- end }}
    REMOTE_AUTH_AUTO_CREATE_USER = {{ ternary "True" "False" .auto_create_user }}
    {{- with .default_groups }}
    REMOTE_AUTH_DEFAULT_GROUPS = [
        {{- range . }}
        {{ . | squote }},
        {{- end }}
    ]
    {{- end }}
    {{- with .default_permissions }}
    REMOTE_AUTH_DEFAULT_PERMISSIONS = {
        {{- range . }}
        {{ .key | squote }}: {{ if eq .value "None" }}{{ .value }}{{ else }}{{ .value | squote }}{{ end }},
        {{- end }}
    }
    {{- end }}
    {{- end }}
    {{- end }}
    SESSION_FILE_PATH = None

    {{- with .Values.netbox.date_time }}
    {{- with .date_format }}
    DATE_FORMAT = {{ . | squote }}
    {{- end }}
    {{- with .short_date_format }}
    SHORT_DATE_FORMAT = {{ . | squote }}
    {{- end }}
    {{- with .time_format }}
    TIME_FORMAT = {{ . | squote }}
    {{- end }}
    {{- with .shot_time_format }}
    SHORT_TIME_FORMAT = {{ . | squote }}
    {{- end }}
    {{- with .date_time_format }}
    DATETIME_FORMAT = {{ . | squote }}
    {{- end }}
    {{- with .short_date_time_format }}
    SHORT_DATETIME_FORMAT = {{ . | squote }}
    {{- end }}
    {{- end }}
{{- end }}
