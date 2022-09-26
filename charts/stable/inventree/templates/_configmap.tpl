{{/* Define the secrets */}}
{{- define "inventree.config" -}}

{{- $configName := printf "%s-inventree-config" (include "tc.common.names.fullname" .) }}
{{- $nginxConfigName := printf "%s-inventree-config-nginx" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  INVENTREE_TIMEZONE: {{ .Values.TZ }}
  INVENTREE_DB_ENGINE: "postgresql"
  INVENTREE_DB_NAME: {{ .Values.postgresql.postgresqlDatabase }}
  INVENTREE_DB_USER: {{ .Values.postgresql.postgresqlUsername }}
  INVENTREE_DB_HOST: {{ printf "%v-%v" .Release.Name "postgresql" }}
  INVENTREE_DB_PORT: "5432"
  INVENTREE_CACHE_PORT: "6379"
  INVENTREE_WEB_PORT: "8000"
  {{- with .Values.inventree.mail.backend }}
  INVENTREE_EMAIL_BACKEND: {{ . }}
  {{- end }}
  {{- with .Values.inventree.mail.host }}
  INVENTREE_EMAIL_HOST: {{ . }}
  {{- end }}
  {{- with .Values.inventree.mail.port }}
  INVENTREE_EMAIL_PORT: {{ . | quote }}
  {{- end }}
  {{- with .Values.inventree.mail.username }}
  INVENTREE_EMAIL_USERNAME: {{ . }}
  {{- end }}
  INVENTREE_EMAIL_TLS: '{{ ternary "True" "False" .Values.inventree.mail.tls | default "False" }}'
  INVENTREE_EMAIL_SSL: '{{ ternary "True" "False" .Values.inventree.mail.ssl | default "False" }}'
  {{- with .Values.inventree.mail.sender }}
  INVENTREE_EMAIL_SENDER: {{ . }}
  {{- end }}
  {{- if .Values.inventree.general.debug }}
  INVENTREE_DEBUG: {{ .Values.inventree.general.debug | quote }}
  {{- end }}
  {{- with .Values.inventree.general.log_level }}
  INVENTREE_LOG_LEVEL: {{ . }}
  {{- end }}
  {{- if .Values.inventree.general.plugins_enabled }}
  INVENTREE_PLUGINS_ENABLED: {{ .Values.inventree.general.plugins_enabled | quote }}
  {{- end }}
  {{- with .Values.inventree.general.login_confirm_days }}
  INVENTREE_LOGIN_CONFIRM_DAYS: {{ . | quote }}
  {{- end }}
  {{- with .Values.inventree.general.login_attempts }}
  INVENTREE_LOGIN_ATTEMPTS: {{ . | quote }}
  {{- end }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $nginxConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  nginx.conf: |-
    server {
      listen {{ .Values.service.main.ports.main.port }};
      real_ip_header proxy_protocol;
      location / {
          proxy_set_header      Host              $http_host;
          proxy_set_header      X-Forwarded-By    $server_addr:$server_port;
          proxy_set_header      X-Forwarded-For   $remote_addr;
          proxy_set_header      X-Forwarded-Proto $scheme;
          proxy_set_header      X-Real-IP         $remote_addr;
          proxy_set_header      CLIENT_IP         $remote_addr;
          proxy_pass_request_headers on;
          proxy_redirect off;
          client_max_body_size 100M;
          proxy_buffering off;
          proxy_request_buffering off;
          proxy_pass http://localhost:8000;
      }
      # Redirect any requests for static files
      location /static/ {
          alias /var/www/static/;
          autoindex on;
          # Caching settings
          expires 30d;
          add_header Pragma public;
          add_header Cache-Control "public";
      }
      # Redirect any requests for media files
      location /media/ {
          alias /var/www/media/;
          # Media files require user authentication
          auth_request /auth;
      }
      # Use the 'user' API endpoint for auth
      location /auth {
          internal;
          proxy_pass http://localhost:8000/auth/;
          proxy_pass_request_body off;
          proxy_set_header Content-Length "";
          proxy_set_header X-Original-URI $request_uri;
      }
    }
{{- end -}}
