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
readinessProbe:
  httpGet:
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
livenessProbe:
  httpGet:
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
startupProbe:
  httpGet:
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
{{- end -}}
