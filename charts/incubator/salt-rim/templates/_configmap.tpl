{{/* Define the configmap */}}
{{- define "saltrim.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $mainPort := .Values.service.main.ports.main.port -}}

nginx-config:
  enabled: true
  data:
    default.conf: |
      server {
          listen {{ $mainPort }} default_server;
          listen [::]:{{ $mainPort }} default_server;
          server_name _;

          location = /favicon.ico { access_log off; log_not_found off; }
          location = /robots.txt  { access_log off; log_not_found off; }

          client_max_body_size 100M;

          location /bar/ {
              proxy_pass {{ printf "http://%v-api:%v" $fullname .Values.service.api.ports.api.targetPort }};
          }

          location /search/ {
              proxy_pass {{ printf "http://%v-search:%v" $fullname .Values.service.search.ports.search.targetPort }};
          }

          location / {
              proxy_pass {{ printf "http://%v:%v" $fullname .Values.service.web.ports.web.targetPort }};
          }
        }
{{- end -}}
