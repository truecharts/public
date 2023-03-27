{{/* Define the nginx container */}}
{{- define "inventree.nginx" -}}
enabled: true
imageSelector: nginxImage
imagePullPolicy: {{ .Values.nginxImage.pullPolicy }}
securityContext:
  runAsUser: 0
  readOnlyRootFilesystem: false
probes:
  startup:
    enabled: false
  readiness:
    enabled: false
  liveness:
    enabled: false
{{- end -}}
