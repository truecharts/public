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
  config.py:
    #########################
    #                       #
    #   Required settings   #
    #                       #
    #########################

    # This is a list of valid fully-qualified domain names (FQDNs) for the NetBox server. NetBox will not permit write
    # access to the server via any other hostnames. The first FQDN in the list will be treated as the preferred name.
    #
    # Example: ALLOWED_HOSTS = ['netbox.example.com', 'netbox.internal.local']
    ALLOWED_HOSTS = []

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
            'HOST': '{{ printf "%v-%v" .Release.Name "redis" }}',
            'PORT': 6379,
            'PASSWORD': '{{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}',
            'DATABASE': 0,
            'SSL': False,
            # Set this to True to skip TLS certificate verification
            # This can expose the connection to attacks, be careful
            # 'INSECURE_SKIP_TLS_VERIFY': False,
        },
        'caching': {
            'HOST': '{{ printf "%v-%v" .Release.Name "redis" }}',
            'PORT': 6379,
            'PASSWORD': '{{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}',
            'DATABASE': 1,
            'SSL': False,
            # Set this to True to skip TLS certificate verification
            # This can expose the connection to attacks, be careful
            # 'INSECURE_SKIP_TLS_VERIFY': False,
        }
    }

    SECRET_KEY = '{{ $secret_key }}'

    #########################
    #                       #
    #   Optional settings   #
    #                       #
    #########################

    # Specify one or more name and email address tuples representing NetBox administrators. These people will be notified of
    # application errors (assuming correct email settings are provided).
    ADMINS = [
        # ('John Doe', 'jdoe@example.com'),
    ]

    # Enable any desired validators for local account passwords below. For a list of included validators, please see the
    # Django documentation at https://docs.djangoproject.com/en/stable/topics/auth/passwords/#password-validation.
    AUTH_PASSWORD_VALIDATORS = [
        # {
        #     'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
        #     'OPTIONS': {
        #         'min_length': 10,
        #     }
        # },
    ]

    # API Cross-Origin Resource Sharing (CORS) settings. If CORS_ORIGIN_ALLOW_ALL is set to True, all origins will be
    # allowed. Otherwise, define a list of allowed origins using either CORS_ORIGIN_WHITELIST or
    # CORS_ORIGIN_REGEX_WHITELIST. For more information, see https://github.com/ottoyiu/django-cors-headers
    CORS_ORIGIN_ALLOW_ALL = False
    CORS_ORIGIN_WHITELIST = [
        # 'https://hostname.example.com',
    ]
    CORS_ORIGIN_REGEX_WHITELIST = [
        # r'^(https?://)?(\w+\.)?example\.com$',
    ]

    # Set to True to enable server debugging. WARNING: Debugging introduces a substantial performance penalty and may reveal
    # sensitive information about your installation. Only enable debugging while performing testing. Never enable debugging
    # on a production system.
    DEBUG = False

    # Email settings
    EMAIL = {
        'SERVER': 'localhost',
        'PORT': 25,
        'USERNAME': '',
        'PASSWORD': '',
        'USE_SSL': False,
        'USE_TLS': False,
        'TIMEOUT': 10,  # seconds
        'FROM_EMAIL': '',
    }

    # Exempt certain models from the enforcement of view permissions. Models listed here will be viewable by all users and
    # by anonymous users. List models in the form `<app>.<model>`. Add '*' to this list to exempt all models.
    EXEMPT_VIEW_PERMISSIONS = [
        # 'dcim.site',
        # 'dcim.region',
        # 'ipam.prefix',
    ]

    # HTTP proxies NetBox should use when sending outbound HTTP requests (e.g. for webhooks).
    # HTTP_PROXIES = {
    #     'http': 'http://10.10.1.10:3128',
    #     'https': 'http://10.10.1.10:1080',
    # }

    # IP addresses recognized as internal to the system. The debugging toolbar will be available only to clients accessing
    # NetBox from an internal IP.
    INTERNAL_IPS = ('127.0.0.1', '::1')

    # Enable custom logging. Please see the Django documentation for detailed guidance on configuring custom logs:
    #   https://docs.djangoproject.com/en/stable/topics/logging/
    LOGGING = {}

    # Automatically reset the lifetime of a valid session upon each authenticated request. Enables users to remain
    # authenticated to NetBox indefinitely.
    LOGIN_PERSISTENCE = False

    # Setting this to True will permit only authenticated users to access any part of NetBox. By default, anonymous users
    # are permitted to access most data in NetBox but not make any changes.
    LOGIN_REQUIRED = False

    # The length of time (in seconds) for which a user will remain logged into the web UI before being prompted to
    # re-authenticate. (Default: 1209600 [14 days])
    LOGIN_TIMEOUT = None

    # The file path where uploaded media such as image attachments are stored. A trailing slash is not needed. Note that
    # the default value of this setting is derived from the installed location.
    # MEDIA_ROOT = '/opt/netbox/netbox/media'

    # By default uploaded media is stored on the local filesystem. Using Django-storages is also supported. Provide the
    # class path of the storage driver in STORAGE_BACKEND and any configuration options in STORAGE_CONFIG. For example:
    # STORAGE_BACKEND = 'storages.backends.s3boto3.S3Boto3Storage'
    # STORAGE_CONFIG = {
    #     'AWS_ACCESS_KEY_ID': 'Key ID',
    #     'AWS_SECRET_ACCESS_KEY': 'Secret',
    #     'AWS_STORAGE_BUCKET_NAME': 'netbox',
    #     'AWS_S3_REGION_NAME': 'eu-west-1',
    # }

    # Expose Prometheus monitoring metrics at the HTTP endpoint '/metrics'
    METRICS_ENABLED = False

    # Enable installed plugins. Add the name of each plugin to the list.
    PLUGINS = []

    # Plugins configuration settings. These settings are used by various plugins that the user may have installed.
    # Each key in the dictionary is the name of an installed plugin and its value is a dictionary of settings.
    # PLUGINS_CONFIG = {
    #     'my_plugin': {
    #         'foo': 'bar',
    #         'buzz': 'bazz'
    #     }
    # }

    # Remote authentication support
    REMOTE_AUTH_ENABLED = False
    REMOTE_AUTH_BACKEND = 'netbox.authentication.RemoteUserBackend'
    REMOTE_AUTH_HEADER = 'HTTP_REMOTE_USER'
    REMOTE_AUTH_AUTO_CREATE_USER = True
    REMOTE_AUTH_DEFAULT_GROUPS = []
    REMOTE_AUTH_DEFAULT_PERMISSIONS = {}

    # This repository is used to check whether there is a new release of NetBox available. Set to None to disable the
    # version check or use the URL below to check for release in the official NetBox repository.
    RELEASE_CHECK_URL = None
    # RELEASE_CHECK_URL = 'https://api.github.com/repos/netbox-community/netbox/releases'

    # The file path where custom reports will be stored. A trailing slash is not needed. Note that the default value of
    # this setting is derived from the installed location.
    # REPORTS_ROOT = '/opt/netbox/netbox/reports'

    # Maximum execution time for background tasks, in seconds.
    RQ_DEFAULT_TIMEOUT = 300

    # The file path where custom scripts will be stored. A trailing slash is not needed. Note that the default value of
    # this setting is derived from the installed location.
    # SCRIPTS_ROOT = '/opt/netbox/netbox/scripts'

    # The name to use for the csrf token cookie.
    CSRF_COOKIE_NAME = 'csrftoken'

    # The name to use for the session cookie.
    SESSION_COOKIE_NAME = 'sessionid'

    SESSION_FILE_PATH = None

    TIME_ZONE = '{{ .Values.TZ }}'

    # Date/time formatting. See the following link for supported formats:
    # https://docs.djangoproject.com/en/stable/ref/templates/builtins/#date
    DATE_FORMAT = 'N j, Y'
    SHORT_DATE_FORMAT = 'Y-m-d'
    TIME_FORMAT = 'g:i a'
    SHORT_TIME_FORMAT = 'H:i:s'
    DATETIME_FORMAT = 'N j, Y g:i a'
    SHORT_DATETIME_FORMAT = 'Y-m-d H:i'
{{- end }}
