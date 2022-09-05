{{/* Define the worker container */}}
{{- define "authentik.worker" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
command:
  - /bin/bash
  - -ec
  - 'until curl --user-agent "goauthentik.io lifecycle Healthcheck" -I http://localhost:{{ .Values.service.main.ports.main.targetPort }}/-/health/live/; do sleep 2; done'
  - '/usr/local/bin/dumb-init -- /lifecycle/ak'
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
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  exec:
    command:
      - /lifecycle/ak
      - healthcheck
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  exec:
    command:
      - /lifecycle/ak
      - healthcheck
  initialDelaySeconds: 120
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
