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
            'HOST': '{{ printf "%v-%v" .Release.Name "redis" }}',
            'PORT': 6379,
            'PASSWORD': '{{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}',
            'DATABASE': 0,
            'SSL': False,
          },
          'caching': {
            'HOST': '{{ printf "%v-%v" .Release.Name "redis" }}',
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
{{- end }}
