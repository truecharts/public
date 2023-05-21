{{/* Define the web container */}}
{{- define "immich.web" -}}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{- include "immich.wait" (dict "variable" "IMMICH_SERVER_URL" "path" "server-info/ping") | nindent 6 }}
  containers:
    web:
      enabled: true
      primary: true
      imageSelector: webImage
      command: /bin/sh
      args: ./entrypoint.sh
      envFrom:
        - configMapRef:
            name: common-config
        - configMapRef:
            name: web-config
        - secretRef:
            name: deps-secret
      probes:
        readiness:
          enabled: true
          type: http
          path: /robots.txt
          port: {{ .Values.service.web.ports.web.port }}
        liveness:
          enabled: true
          type: http
          path: /robots.txt
          port: {{ .Values.service.web.ports.web.port }}
        startup:
          enabled: true
          type: http
          path: /robots.txt
          port: {{ .Values.service.web.ports.web.port }}
{{- end -}}

{{- define "immich.web.service" -}}
enabled: true
type: ClusterIP
targetSelector: web
ports:
  web:
    enabled: true
    primary: true
    port: 10000
    protocol: http
    targetSelector: web
{{- end -}}
