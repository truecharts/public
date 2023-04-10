{{/* Define the proxy container */}}
{{- define "authentik.proxy" -}}
enabled: true
imageSelector: proxyImage
envFrom:
  - secretRef:
      name: 'proxy-secret'
  - configMapRef:
      name: 'proxy-config'
probes:
  readiness:
    enabled: true
    type: http
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
  liveness:
    enabled: true
    type: http
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
  startup:
    enabled: true
    type: http
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
{{- end -}}
