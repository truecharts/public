{{/* Define the web container */}}
{{- define "immich.web" -}}
{{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
{{- $url := printf "http://%v-server:%v/server-info/ping" $fname .Values.service.server.ports.server.port }}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{- include "immich.wait" (dict "url" $url) | nindent 6 }}
  containers:
    web:
      enabled: true
      primary: true
      imageSelector: webImage
      envFrom:
        - configMapRef:
            name: web-config
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
