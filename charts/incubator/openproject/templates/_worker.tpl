{{/* Define the worker container */}}
{{- define "openproject.worker" -}}
image: {{ .Values.proxyImage.repository }}:{{ .Values.proxyImage.tag }}
imagePullPolicy: {{ .Values.proxyImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
args:
  - ./docker/prod/worker
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-common-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-common-config'
volumeMounts:
  - name: assets
    mountPath: /var/openprojects/assets
# readinessProbe:

#   initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
#   timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
#   periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
#   failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
# livenessProbe:

#   initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
#   timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
#   periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
#   failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
# startupProbe:

#   initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
#   timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
#   periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
#   failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
