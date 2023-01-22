{{/* Define the configmap */}}
{{- define "vikunja.nginx" -}}
nginx: |
  server {
    listen {{ .Values.service.main.ports.main.port }};
    location / {
        proxy_pass http://localhost:80;
    }
    location ~* ^/(api|dav|\.well-known)/ {
        proxy_pass http://localhost:3456;
        client_max_body_size {{ .Values.vikunja.files.maxsize | upper | trimSuffix "B" }};
    }
  }
{{- end -}}
