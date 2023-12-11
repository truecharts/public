{{/* Define the configmap */}}
{{- define "wger.configmap" -}}

{{- $configName := printf "%s-wger-configmap" (include "tc.common.names.fullname" .) }}
{{- $nginxConfigName := printf "%s-wger-nginx-config" (include "tc.common.names.fullname" .) }}

---
{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Dependencies */}}
  DJANGO_DB_ENGINE: "django.db.backends.postgresql"
  DJANGO_DB_DATABASE: {{ .Values.postgresql.postgresqlDatabase }}
  DJANGO_DB_USER: {{ .Values.postgresql.postgresqlUsername }}
  DJANGO_DB_PORT: "5432"
  DJANGO_DB_HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  DJANGO_CACHE_BACKEND: "django_redis.cache.RedisCache"
  DJANGO_CACHE_CLIENT_CLASS: "django_redis.client.DefaultClient"
  DJANGO_CACHE_TIMEOUT: "1296000"
  TIME_ZONE: {{ .Values.TZ | quote }}
  {{/* True, not true */}}
  WGER_USE_GUNICORN: "True"
  {{/* User Defined */}}
  {{/* General */}}
  {{- with .Values.wger.general.site_url }}
  SITE_URL: {{ . | quote }}
  {{- end }}
  {{- with .Values.wger.general.exercise_cache_ttl }}
  EXERCISE_CACHE_TTL: {{ . | quote }}
  {{- end }}
  ALLOW_REGISTRATION: {{ ternary "True" "False" .Values.wger.general.allow_registration | squote }}
  ALLOW_GUEST_USERS: {{ ternary "True" "False" .Values.wger.general.allow_guest_users | squote }}
  ALLOW_UPLOAD_VIDEOS: {{ ternary "True" "False" .Values.wger.general.allow_upload_videos | squote }}
  SYNC_EXERCISES_ON_STARTUP: {{ ternary "True" "False" .Values.wger.general.sync_exercises_on_startup | squote }}
  DOWNLOAD_EXERCISE_IMAGES_ON_STARTUP: {{ ternary "True" "False" .Values.wger.general.download_exercise_images_on_startup | squote }}
  DJANGO_PERFORM_MIGRATIONS: {{ ternary "True" "False" .Values.wger.general.django_perform_migrations | squote }}
  DJANGO_DEBUG: {{ ternary "True" "False" .Values.wger.general.django_debug | squote }}
  {{/* Captcha */}}
  NOCAPTCHA: {{ ternary "True" "False" .Values.wger.captcha.nocaptcha | squote }}
  {{/* Mail */}}
  {{- if .Values.wger.mail.enable_email }}
  {{/* Any value is considered true */}}
  ENABLE_EMAIL: "True"
  {{- end }}
  FROM_EMAIL: {{ .Values.wger.mail.from_email | quote }}
  EMAIL_HOST: {{ .Values.wger.mail.email_host | quote }}
  EMAIL_PORT: {{ .Values.wger.mail.email_port | quote }}
  EMAIL_USE_TLS: {{ ternary "True" "False" .Values.wger.mail.email_use_tls | squote }}
  EMAIL_USE_SSL: {{ ternary "True" "False" .Values.wger.mail.email_use_ssl | squote }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $nginxConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  nginx.conf: |-
    upstream wger {
        server localhost:8000;
    }
    server {
        listen {{ .Values.service.main.ports.main.port }};
        location / {
            proxy_pass http://localhost:8000;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_redirect off;
        }
        location /static/ {
            alias /static/;
        }
        location /media/ {
            alias /media/;
        }
        # Increase max body size to allow for video uploads
        client_max_body_size 100M;
    }
{{- end }}
