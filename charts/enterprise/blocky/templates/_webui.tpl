{{- define "blocky.frontend" -}}
image: {{ .Values.WebUIImage.repository }}:{{ .Values.WebUIImage.tag }}
imagePullPolicy: {{ .Values.WebUIImage.pullPolicy }}
securityContext:
  runAsUser: 568
  runAsGroup: 568
  readOnlyRootFilesystem: true
  runAsNonRoot: true
ports:
  - containerPort: {{ .Values.service.main.ports.main.targetPort }}
    name: main
readinessProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
env:
  - name: NODE_ENV
    value: "production"
{{- $url := .Values.webUI.apiURL }}
{{- if .Values.ingress.main.enabled }}
  {{- with (first .Values.ingress.main.hosts) }}
  {{- $url = (  printf "https://%s" .host ) }}
  {{- end }}
{{- else }}
{{- end }}
  - name: API_URL
    value: "{{ $url }}"
{{- end -}}
