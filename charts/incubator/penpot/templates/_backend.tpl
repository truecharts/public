{{/* Define the backend container */}}
{{- define "penpot.backend" -}}
image: {{ .Values.backendImage.repository }}:{{ .Values.backendImage.tag }}
imagePullPolicy: '{{ .Values.backendImage.pullPolicy }}'
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
volumeMounts:
  - name: data
    mountPath: {{ .Values.persistence.data.mountPath }}
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-common-secret'
{{/*
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
*/}}
{{- end }}
