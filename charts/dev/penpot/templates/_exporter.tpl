{{/* Define the exporter container */}}
{{- define "penpot.exporter" -}}
enabled: true
imageSelector: exporterImage
imagePullPolicy: '{{ .Values.exporterImage.pullPolicy }}'
envFrom:
  - secretRef:
      name: 'common-secret'
  - secretRef:
      name: 'exporter-secret'
  - secretRef:
      name: 'backend-exporter-secret'
probes:
  readiness:
    tcpSocket:
      port: 6061




  liveness:

    tcpSocket:
      port: 6061




  startup:
    tcpSocket:
      port: 6061




{{- end }}
