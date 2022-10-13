{{/* Define the configmap */}}
{{- define "immich.config" -}}

{{- $serverConfigName := printf "%s-server-config" (include "tc.common.names.fullname" .) }}
{{- $commonConfigName := printf "%s-common-config" (include "tc.common.names.fullname" .) }}
{{- $proxyConfigName := printf "%s-proxy-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $serverConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DB_HOSTNAME: {{ printf "%v-%v" .Release.Name "postgresql" }}
  DB_USERNAME: {{ .Values.postgresql.postgresqlUsername }}
  DB_DATABASE_NAME: {{ .Values.postgresql.postgresqlDatabase }}
  DB_PORT: "5432"
  REDIS_HOSTNAME: {{ printf "%v-%v" .Release.Name "redis" }}
  REDIS_PORT: "6379"
  REDIS_DBINDEX: "0"
  {{/* User Defined */}}
  DISABLE_REVERSE_GEOCODING: {{ .Values.immich.disable_reverse_geocoding | quote }}
  REVERSE_GEOCODING_PRECISION: {{ .Values.immich.reverse_geocoding_precision | quote }}
  ENABLE_MAPBOX: {{ .Values.immich.mapbox_enable | quote }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $commonConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  NODE_ENV: production
  {{/* User Defined */}}
  {{- with .Values.immich.public_login_page_message }}
  PUBLIC_LOGIN_PAGE_MESSAGE: {{ . }}
  {{- end }}
  LOG_LEVEL: {{ .Values.immich.log_level }}
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $proxyConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  nginx.conf: |
    worker_processes auto;
    error_log /var/log/nginx/error.log;
    pid /tmp/nginx.pid;

    # Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
    include /usr/share/nginx/modules/*.conf;

    events {
        worker_connections 1024;
    }

    http {
      map $http_upgrade $connection_upgrade {
        default upgrade;
        '' close;
      }

      client_body_temp_path /tmp/client_temp;
      proxy_temp_path       /tmp/proxy_temp_path;
      fastcgi_temp_path     /tmp/fastcgi_temp;
      uwsgi_temp_path       /tmp/uwsgi_temp;
      scgi_temp_path        /tmp/scgi_temp;

      # events {
      #   worker_connections 1000;
      # }

      server {
        gzip on;
        gzip_min_length 1000;
        gunzip on;

        client_max_body_size 50000M;

        listen {{ .Values.service.main.ports.main.port }};
        access_log off;

        location /api {
          # Compression
          gzip_static on;
          gzip_min_length 1000;
          gzip_comp_level 2;

          proxy_buffering off;
          proxy_buffer_size 16k;
          proxy_busy_buffers_size 24k;
          proxy_buffers 64 4k;
          proxy_force_ranges on;

          proxy_http_version 1.1;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_set_header Host $host;

          rewrite /api/(.*) /$1 break;

          # Server Container
          proxy_pass http://immich-server:3001;
        }

        location / {
          # Compression
          gzip_static on;
          gzip_min_length 1000;
          gzip_comp_level 2;

          proxy_buffering off;
          proxy_buffer_size 16k;
          proxy_busy_buffers_size 24k;
          proxy_buffers 64 4k;
          proxy_force_ranges on;

          proxy_http_version 1.1;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_set_header Host $host;

          # Web Container
          proxy_pass http://immich-web:3000;
        }
      }
    }
{{- end -}}
