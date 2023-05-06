{{/* Define the proxy container */}}
{{- define "immich.proxy" -}}
enabled: true
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
