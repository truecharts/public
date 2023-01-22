{{/* Define the configmap */}}
{{- define "vikunja.nginx" -}}
nginx: |
  server {
    listen {{ .Values.service.main.ports.main.port }};
    location / {
        proxy_pass http://localhost:80;
    }
    location ~* ^/(api|dav|\.well-known)/ {
        proxy_pass http://localhost:{{ .Values.vikunja.service.interface | replace ":" "" }};
        client_max_body_size {{ .Values.env.VIKUNJA_FILES_MAXSIZE | upper | trimSuffix "B" }};
    }
  }
{{- end -}}
