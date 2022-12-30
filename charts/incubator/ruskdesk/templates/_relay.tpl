{{/* Define the relay container */}}
{{- define "rustdesk.relay" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
extraArgs:
  - hbbr
volumeMounts:
  - name: root
    mountPath: {{ .Values.persistence.root.mountPath }}
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-common-secret'
readinessProbe:
  tcpSocket:
    port: 21117
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  tcpSocket:
    port: 21117
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  tcpSocket:
    port: 21117
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end }}
