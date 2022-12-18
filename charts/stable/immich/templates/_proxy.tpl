{{/* Define the proxy container */}}
{{- define "immich.proxy" -}}
  {{- if hasKey .Values "imageProxy" -}} {{/* For smooth upgrade, Remove later */}}
    {{- $img := .Values.imageProxy -}}
    {{- $_ := set .Values "proxyImage" (dict "repository" $img.repository "tag" $img.tag "pullPolicy" $img.pullPolicy) -}}
  {{- end -}}
  {{- if not .Values.service.main.ports.main.targetPort -}} {{/* For smooth upgrade, Remove later */}}
    {{- $_ := set .Values.service.main.ports.main "targetPort" 8080 -}}
  {{- end }}
image: {{ .Values.proxyImage.repository }}:{{ .Values.proxyImage.tag }}
imagePullPolicy: {{ .Values.proxyImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
envFrom:
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-common-config'
ports:
  - containerPort: {{ .Values.service.main.ports.main.targetPort }}
    name: main
readinessProbe:
  httpGet:
    path: /api/server-info/ping
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /api/server-info/ping
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /api/server-info/ping
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
