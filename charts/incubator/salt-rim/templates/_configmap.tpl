{{/* Define the configmap */}}
{{- define "saltrim.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $mainPort := .Values.service.main.ports.main.port -}}

{{- $searchUrl := printf "http://%v-search:%v" $fullname .Values.service.search.ports.search.targetPort -}}
{{- $webUrl := printf "http://%v-web:%v" $fullname .Values.service.web.ports.web.targetPort -}}
{{- $apiUrl := printf "http://%v-api:%v" $fullname .Values.service.api.ports.api.targetPort -}}

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
              proxy_pass {{ $apiUrl }};
          }

          location /search/ {
              proxy_pass {{ $searchUrl }};
          }

          location / {
              proxy_pass {{ $webUrl }};
          }
        }
{{- end -}}
