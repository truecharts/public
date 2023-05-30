{{- define "immich.proxy" -}}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{- include "immich.wait" (dict "variable" "IMMICH_SERVER_URL" "path" "server-info/ping") | nindent 6 }}
  containers:
    proxy:
      enabled: true
      primary: true
      imageSelector: proxyImage
      envFrom:
        - configMapRef:
            name: common-config
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
