{{/* Define the backend container */}}
{{- define "penpot.backend" -}}
enabled: true
imageSelector: backendImage
imagePullPolicy: '{{ .Values.backendImage.pullPolicy }}'
envFrom:
  - secretRef:
      name: 'common-secret'
  - secretRef:
      name: 'backend-exporter-secret'
probes:
  readiness:
    tcpSocket:
      port: 6060




  liveness:
    tcpSocket:
      port: 6060




  startup:
    tcpSocket:
      port: 6060




{{- end }}
