{{/* Define the imaginary container */}}
{{- define "nextcloud.imaginary" -}}
enabled: true
imageSelector: imaginaryImage
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
securityContext:
  runAsUser: 33
  runAsGroup: 33
  readOnlyRootFilesystem: true
args: ["-enable-url-source"]
env:
  'PORT': '9090'
probes:
  readiness:

    path: /
    port: 9090




  liveness:

    path: /
    port: 9090




  startup:

    path: /
    port: 9090




{{- end -}}
