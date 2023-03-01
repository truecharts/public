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
  liveness:
    httpGet:
      path: /
      port: {{ .Values.service.main.ports.main.targetPort }}
  startup:
    httpGet:
      path: /
      port: {{ .Values.service.main.ports.main.targetPort }}
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
