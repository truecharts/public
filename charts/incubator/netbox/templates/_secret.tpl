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
            # 'INSECURE_SKIP_TLS_VERIFY': False,
        },
        'caching': {
            'HOST': '{{ printf "%v-%v" .Release.Name "redis" }}',
            'PORT': 6379,
            'PASSWORD': '{{ .Values.redis.redisPassword | trimAll "\"" | b64enc }}',
            'DATABASE': 1,
            'SSL': False,
            # 'INSECURE_SKIP_TLS_VERIFY': False,
        }
    }

    SECRET_KEY = '{{ $secret_key }}'


{{- end }}
