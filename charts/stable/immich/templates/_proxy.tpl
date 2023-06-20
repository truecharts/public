{{- define "immich.proxy" -}}
{{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
{{- $url := printf "http://%v-server:%v/server-info/ping" $fname .Values.service.server.ports.server.port }}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{- include "immich.wait" (dict "url" $url) | nindent 6 }}
  containers:
    proxy:
      enabled: true
      primary: true
      imageSelector: proxyImage
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
