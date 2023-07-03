{{- define "mealie.api" -}}
image: {{ .Values.apiImage.repository }}:{{ .Values.apiImage.tag }}
imagePullPolicy: {{ .Values.apiImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.securityContext.container.runAsUser }}
  runAsGroup: {{ .Values.securityContext.container.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.container.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.container.runAsNonRoot }}
envFrom:
  - secretRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-api-secret'
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-api-config'
volumeMounts:
  - name: data
    mountPath: "/app/data"
readinessProbe:
  httpGet:
    path: /docs
    port: {{ .Values.service.api.ports.api.port }}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /docs
    port: {{ .Values.service.api.ports.api.port }}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /docs
    port: {{ .Values.service.api.ports.api.port }}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
{{- end -}}
