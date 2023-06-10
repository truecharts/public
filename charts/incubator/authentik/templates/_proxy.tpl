{{/* Define the proxy container */}}
{{- define "authentik.proxy.container" -}}
enabled: true
primary: false
imageSelector: proxyImage
securityContext:
  readOnlyRootFilesystem: true
  runAsNonRoot: true
envFrom:
  - secretRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-proxy-secret'
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-proxy-config'
ports:
  - containerPort: {{ .Values.service.proxyhttps.ports.proxyhttps.targetPort }}
    name: proxyhttps
  - containerPort: {{ .Values.service.proxyhttp.ports.proxyhttp.targetPort }}
    name: proxyhttp
{{- if .Values.metrics.enabled }}
  - containerPort: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
    name: proxymetrics
{{- end }}
probes:
  readiness:
    enabled: true
    type: {{ .Values.service.proxymetrics.ports.proxymetrics.protocol }}
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
  liveness:
    enabled: true
    type: {{ .Values.service.proxymetrics.ports.proxymetrics.protocol }}
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
  startup:
    enabled: true
    type: {{ .Values.service.proxymetrics.ports.proxymetrics.protocol }}
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
{{- end -}}
