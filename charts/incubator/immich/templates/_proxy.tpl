{{/* Define the proxy container */}}
{{- define "immich.proxy" -}}
image: {{ .Values.imageProxy.repository }}:{{ .Values.imageProxy.tag }}
imagePullPolicy: {{ .Values.imageProxy.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
envFrom:
  # TODO: Split configmaps and only mount what's needed
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-immich-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-immich-config'
volumeMounts:
  - name: proxy-conf
    mountPath: /etc/nginx
    readOnly: true
ports:
  - containerPort: {{ .Values.service.main.ports.main.port }}
    name: main
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
