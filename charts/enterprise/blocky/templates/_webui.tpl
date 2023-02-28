{{- define "blocky.frontend" -}}
image: {{ .Values.WebUIImage.repository }}:{{ .Values.WebUIImage.tag }}
imagePullPolicy: {{ .Values.WebUIImage.pullPolicy }}
securityContext:
  runAsUser: 568
  runAsGroup: 568
  readOnlyRootFilesystem: true
  runAsNonRoot: true
Probe:
  readiness:
    httpGet:
      path: /
      port: {{ .Values.service.main.ports.main.targetPort }}
    initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
    timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
    periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
    failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
  liveness:
    httpGet:
      path: /
      port: {{ .Values.service.main.ports.main.targetPort }}
    initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
    timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
    periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
    failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
  startup:
    httpGet:
      path: /
      port: {{ .Values.service.main.ports.main.targetPort }}
    initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
    timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
    periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
    failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
env:
  NODE_ENV: "production"
{{- $url := .Values.webUI.apiURL }}
{{- if .Values.ingress.main.enabled }}
  {{- with (first .Values.ingress.main.hosts) }}
  {{- $url = (  printf "https://%s" .host ) }}
  {{- end }}
{{- else }}
{{- end }}
  API_URL: "{{ $url }}"
{{- end -}}
