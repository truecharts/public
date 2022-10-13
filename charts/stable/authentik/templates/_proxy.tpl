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
{{- if .Values.metrics.enabled }}
  - containerPort: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
    name: proxymetrics
{{- end }}
readinessProbe:
  httpGet:
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.proxymetrics.ports.proxymetrics.targetPort }}
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
