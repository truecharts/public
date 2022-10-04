{{/* Define the joex container */}}
{{- define "docspell.joex" -}}
image: {{ .Values.joexImage.repository }}:{{ .Values.joexImage.tag }}
imagePullPolicy: {{ .Values.joexImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
envFrom:
  # - secretRef:
  #     name: '{{ include "tc.common.names.fullname" . }}-joex-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-joex-config'
ports:
  - containerPort: {{ .Values.service.joex.ports.joex.port }}
    name: joex
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
{{- end -}}
