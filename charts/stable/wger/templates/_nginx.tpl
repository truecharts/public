{{/* Define the nginx container */}}
{{- define "wger.nginx" -}}
enabled: true
imageSelector: nginxImage
imagePullPolicy: {{ .Values.nginxImage.pullPolicy }}
securityContext:
  runAsUser: 0
  runAsGroup: 1000
  readOnlyRootFilesystem: false
{{- end -}}
