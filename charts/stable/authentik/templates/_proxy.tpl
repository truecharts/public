{{/* Define the proxy container */}}
{{- define "authentik.proxy" -}}
enabled: true
imageSelector: proxyImage
imagePullPolicy: {{ .Values.proxyImage.pullPolicy }}
envFrom:
  - secretRef:
      name: 'proxy-secret'
  - configMapRef:
      name: 'proxy-config'
probes:
  readiness:

    path: /outpost.goauthentik.io/ping
      port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}




  liveness:

    path: /outpost.goauthentik.io/ping
      port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}




  startup:

    path: /outpost.goauthentik.io/ping
      port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}




{{- end -}}
