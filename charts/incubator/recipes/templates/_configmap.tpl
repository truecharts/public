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
            listen 80;
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
              proxy_pass '{{ printf "http://%v:%v" (include "tc.v1.common.lib.chart.names.fullname" $) 8080 }}';
              proxy_set_header X-Forwarded-Proto $http_x_forwarded_proto;
            }
          }
        }
{{- end -}}
