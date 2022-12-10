{{/* Define the backend container */}}
{{- define "penpot.backend" -}}
image: {{ .Values.backendImage.repository }}:{{ .Values.backendImage.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'

podSecurityContext:
  runAsGroup: 568
  runAsUser: 568

securityContext:
  readOnlyRootFilesystem: false
  runAsNonRoot: true

persistence:
  config:
    enabled: true
    mountPath: /opt/data

env:
  - name: 'PENPOT_PUBLIC_URI'
    value: '{{ .Values.penpot.public_uri | quote }}'
{{- end }}
