{{/* Define the ml container */}}
{{- define "immich.microservices" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
command:
  - /bin/sh
  - ./start-microservices.sh
volumeMounts:
  - name: uploads
    mountPath: {{ .Values.persistence.uploads.mountPath }}
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-immich-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-common-config'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-server-config'
readinessProbe:
  exec:
    command:
      - /bin/sh
      - -c
      - |
        ps -a | grep -v grep | grep -q microservices || exit 1
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  exec:
    command:
      - /bin/sh
      - -c
      - |
        ps -a | grep -v grep | grep -q microservices || exit 1
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  exec:
    command:
      - /bin/sh
      - -c
      - |
        ps -a | grep -v grep | grep -q microservices || exit 1
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
