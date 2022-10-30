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

    ADMINS = [
        {{- range .Values.netbox.admins }}
        ({{ .name | squote }},{{ .email | squote }}),
        {{- end }}
    ]

    AUTH_PASSWORD_VALIDATORS = [
        {{- range .Values.netbox.auth_password_validators }}
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
