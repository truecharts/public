{{/* Define the worker container */}}
{{- define "authentik.worker" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: false
  runAsNonRoot: true
args: ["worker"]
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-authentik-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-authentik-config'
volumeMounts:
  - name: media
    mountPath: "/media"
  - name: templates
    mountPath: "/templates"
  - name: certs
    mountPath: "/certs"
  - name: geoip
    mountPath: "/geoip"
readinessProbe:
  exec:
    command:
      - /lifecycle/ak
      - healthcheck
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  exec:
    command:
      - /lifecycle/ak
      - healthcheck
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  exec:
    command:
      - /lifecycle/ak
      - healthcheck
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
