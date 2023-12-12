{{/* Define the secret */}}
{{- define "netbox.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

{{- $secret_key := "" }}
{{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  {{- $secret_key = (index .data "secret_key") | b64dec }}
{{- else }}
  {{- $secret_key = randAlphaNum 64 | b64enc }}
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
        '127.0.0.1',
        '::1',
        {{- range .Values.netbox.allowed_hosts }}
        {{ . | squote }},
        {{- end }}
    ]

    DATABASE = {
        'NAME': '{{ .Values.postgresql.postgresqlDatabase }}',
        'USER': '{{ .Values.postgresql.postgresqlUsername }}',
        'PASSWORD': '{{ .Values.postgresql.postgresqlPassword | trimAll "\"" }}',
        'HOST': '{{ printf "%v-%v" .Release.Name "postgresql" }}',
        'PORT': '5432',
        'CONN_MAX_AGE': 300,
    }

    REDIS = {
        'tasks': {
            'HOST': '{{ printf "%v-%v" .Release.Name "redis" }}',
            'PORT': 6379,
            'PASSWORD': '{{ .Values.redis.redisPassword | trimAll "\"" }}',
            'DATABASE': 0,
            'SSL': False,
        },
        'caching': {
            'HOST': '{{ printf "%v-%v" .Release.Name "redis" }}',
            'PORT': 6379,
            'PASSWORD': '{{ .Values.redis.redisPassword | trimAll "\"" }}',
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

    {{- with .Values.netbox.allowed_urls_schemes}}
    ALLOWED_URL_SCHEMES = [
        {{- range . }}
        {{ . | squote }},
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

    {{- with .Values.netbox.banner.top }}
    BANNER_TOP = {{ . | squote }}
    {{- end }}

    {{- with .Values.netbox.banner.bottom }}
    BANNER_BOTTOM = {{ . | squote }}
    {{- end }}

    {{- with .Values.netbox.banner.login }}
    BANNER_LOGIN = {{ . | squote }}
    {{- end }}

    {{- if or .Values.netbox.retention.changelog (eq (int .Values.netbox.retention.changelog) 0) }}
    CHANGELOG_RETENTION = {{ .Values.netbox.retention.changelog }}
    {{- end }}

    {{- if or .Values.netbox.retention.job_result (eq (int .Values.netbox.retention.job_result) 0) }}
    JOBRESULT_RETENTION = {{ .Values.netbox.retention.job_result }}
    {{- end }}

    PREFER_IPV4 = {{ ternary "True" "False" .Values.netbox.prefer_ipv4 }}

    ENFORCE_GLOBAL_UNIQUE = {{ ternary "True" "False" .Values.netbox.enforce_global_unique }}

    GRAPHQL_ENABLED = {{ ternary "True" "False" .Values.netbox.graphql_enabled }}

    {{- with .Values.netbox.maps_url }}
    MAPS_URL = {{ . | squote }}
    {{- end }}

    {{- if or .Values.netbox.max_page_size (eq (int .Values.netbox.max_page_size) 0) }}
    MAX_PAGE_SIZE = {{ .Values.netbox.max_page_size }}
    {{- end }}

    {{- if or .Values.netbox.paginate_count (eq (int .Values.netbox.paginate_count) 0) }}
    PAGINATE_COUNT = {{ .Values.netbox.paginate_count }}
    {{- end }}

    {{- with .Values.netbox.powerfeed.default_amperage }}
    POWERFEED_DEFAULT_AMPERAGE = {{ . }}
    {{- end }}

    {{- with .Values.netbox.powerfeed.default_max_utilization }}
    POWERFEED_DEFAULT_MAX_UTILIZATION = {{ . }}
    {{- end }}

    {{- with .Values.netbox.powerfeed.default_voltage }}
    POWERFEED_DEFAULT_VOLTAGE = {{ . }}
    {{- end }}

    {{- with .Values.netbox.rack.elevation_default_unit_height }}
    RACK_ELEVATION_DEFAULT_UNIT_HEIGHT = {{ . }}
    {{- end }}

    {{- with .Values.netbox.rack.elevation_default_unit_width }}
    RACK_ELEVATION_DEFAULT_UNIT_WIDTH = {{ . }}
    {{- end }}

    {{- with .Values.netbox.napalm.username }}
    NAPALM_USERNAME = {{ . | squote }}
    {{- end }}

    {{- with .Values.netbox.napalm.password }}
    NAPALM_PASSWORD = {{ . | squote }}
    {{- end }}

    {{- with .Values.netbox.napalm.timeout }}
    NAPALM_TIMEOUT = {{ . }}
    {{- end }}

    {{- with .Values.netbox.napalm.args }}
    NAPALM_ARGS = {
        {{- range . }}
        {{ .arg | squote }}: {{ .value | squote }},
        {{- end }}
    }
    {{- end }}

    {{- with .Values.netbox.csrf_trusted_origin }}
    CSRF_TRUSTED_ORIGINS = [
      {{ . | squote }},
    ]
    {{- end }}

    {{- with .Values.netbox.csrf_cookie_name }}
    CSRF_COOKIE_NAME = {{ . | squote }}
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
        '127.0.0.1',
        '::1',
        {{- range . }}
        {{ . | squote }},
        {{- end }}
    )
    {{- end }}

    LOGIN_PERSISTENCE = {{ ternary "True" "False" .Values.netbox.login_persistence }}

    LOGIN_REQUIRED = {{ ternary "True" "False" .Values.netbox.login_required }}

    {{- with .Values.netbox.login_timeout }}
    LOGIN_TIMEOUT = {{ . }}
    {{- end }}

    METRICS_ENABLED = {{ ternary "True" "False" .Values.metrics.enabled }}

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

    {{- $enabled_plugins := list -}}
    {{- with .Values.netbox.plugin_config -}}
      {{- range . -}}
        {{- if .enabled -}}
          {{- $enabled_plugins = append $enabled_plugins .plugin_name -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

    {{- with $enabled_plugins }}
    PLUGINS = [
        {{- range . }}
        {{ . | squote }},
        {{- end }}
    ]
    {{- end }}

    {{/*
    TODO: Consider template plugins here, so it's easier to config on UI
    https://github.com/netbox-community/netbox/wiki/Plugins
    */}}
    {{- with .Values.netbox.plugin_config }}
    PLUGINS_CONFIG = {
        {{- range . }}
        {{- if .enabled }}
        {{ .plugin_name | squote }}: {
            {{- range .config }}
            {{ .key | squote }}: {{ .value | squote }},
            {{- end }}
        }
        {{- end }}
        {{- end }}
    }
    {{- end }}

    {{- with .Values.netbox.rq_default_timeout }}
    RQ_DEFAULT_TIMEOUT = {{ . }}
    {{- end }}

    {{- with .Values.netbox.session_cookie_name }}
    SESSION_COOKIE_NAME = {{ . | squote }}
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
