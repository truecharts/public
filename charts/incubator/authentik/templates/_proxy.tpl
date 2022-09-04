{{/* Define the proxy container */}}
{{- define "authentik.proxy" -}}
image: {{ .Values.proxyImage.repository }}:{{ .Values.proxyImage.tag }}
imagePullPolicy: {{ .Values.proxyImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: true
  runAsNonRoot: true
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-proxy-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-proxy-config'
ports:
  - containerPort: {{ .Values.service.proxyhttps.ports.proxyhttps.targetPort }}
    name: proxyhttps
  - containerPort: {{ .Values.service.proxyhttp.ports.proxyhttp.targetPort }}
    name: proxyhttp
{{- if .Values.outposts.proxy.metrics }}
  - containerPort: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
    name: proxymetrics
{{- end }}
readinessProbe:
  httpGet:
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
    path: /outpost.goauthentik.io/ping
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
    path: /outpost.goauthentik.io/ping
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  httpGet:
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
    path: /outpost.goauthentik.io/ping
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
