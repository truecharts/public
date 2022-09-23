{{- define "mealie.api" -}}
image: {{ .Values.apiImage.repository }}:{{ .Values.apiImage.tag }}
imagePullPolicy: {{ .Values.apiImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-api-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-api-config'
volumeMounts:
  - name: data
    mountPath: "/app/data"
readinessProbe:
  httpGet:
    path: /docs
    port: {{ .Values.service.api.ports.api.targetPort }}
    {{/* port: {{ .Values.service.api.ports.api.targetPort }} */}}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /docs
    port: {{ .Values.service.api.ports.api.targetPort }}
    {{/* port: {{ .Values.service.api.ports.api.targetPort }} */}}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /docs
    port: {{ .Values.service.api.ports.api.targetPort }}
    {{/* port: {{ .Values.service.api.ports.api.targetPort }} */}}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
{{- end -}}
