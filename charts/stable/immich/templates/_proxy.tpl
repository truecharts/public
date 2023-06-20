{{- define "immich.proxy" -}}
{{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
{{- $serverUrl := printf "http://%v-server:%v/server-info/ping" $fname .Values.service.server.ports.server.port }}
{{- $webUrl := printf "http://%v-web:%v/robots.txt" $fname .Values.service.web.ports.web.port }}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{/* Wait for server */}}
      {{- include "immich.wait" (dict "url" $serverUrl) | nindent 6 }}
      {{/* Wait for web, otherwise nginx will fail to find host */}}
      {{- include "immich.wait" (dict "url" $webUrl) | nindent 6 }}
  containers:
    proxy:
      enabled: true
      primary: true
      imageSelector: proxyImage
      securityContext:
        capabilities:
          disableS6Caps: true
          add:
            - CHOWN
            - SETUID
            - SETGID
      envFrom:
        - configMapRef:
            name: proxy-config
      probes:
        readiness:
          enabled: true
          type: http
          path: /api/server-info/ping
          port: {{ .Values.service.main.ports.main.targetPort }}
        liveness:
          enabled: true
          type: http
          path: /api/server-info/ping
          port: {{ .Values.service.main.ports.main.targetPort }}
        startup:
          enabled: true
          type: http
          path: /api/server-info/ping
          port: {{ .Values.service.main.ports.main.targetPort }}
{{- end -}}
