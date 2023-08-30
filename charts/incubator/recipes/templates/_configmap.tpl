{{/* Define the configmap */}}
{{- define "recipes.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

nginx-config:
  enabled: true
  data:
    nginx.conf: |
      events {
          worker_connections 1024;
        }
        http {
          include /etc/nginx/mime.types;
          server {
            listen {{ .Values.service.main.ports.main.port }};
            server_name _;
            client_max_body_size 16M;
            # serve media files
            location /media/ {
              alias /media/;
            }
            # serve static files
            location /static/ {
              alias /static/;
            }
            # pass requests for dynamic content to gunicorn
            location / {
              proxy_set_header Host $http_host;
              proxy_pass http://localhost:{{ .Values.service.main.ports.main.port }};
              proxy_set_header X-Forwarded-Proto $http_x_forwarded_proto;
            }
          }
        }
{{- end -}}
