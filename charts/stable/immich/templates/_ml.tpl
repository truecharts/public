{{/* Define the ml container */}}
{{- define "immich.ml" -}}
image: {{ .Values.imageML.repository }}:{{ .Values.imageML.tag }}
imagePullPolicy: {{ .Values.imageML.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
command:
  - /bin/sh
  - -c
  - chmod +x ./entrypoint.sh && ./entrypoint.sh
volumeMounts:
  - name: uploads
    mountPath: {{ .Values.persistence.uploads.mountPath }}
envFrom:
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-common-config'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-server-config'
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-immich-secret'
#TODO: Add probes, probably checking if process is running?
# readinessProbe:
#   httpGet:
#     path: /
#     port: {{ .Values.service.main.ports.main.port }}
#   initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
#   timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
#   periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
#   failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
# livenessProbe:
#   httpGet:
#     path: /
#     port: {{ .Values.service.main.ports.main.port }}
#   initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
#   timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
#   periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
#   failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
# startupProbe:
#   httpGet:
#     path: /
#     port: {{ .Values.service.main.ports.main.port }}
#   initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
#   timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
#   periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
#   failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
