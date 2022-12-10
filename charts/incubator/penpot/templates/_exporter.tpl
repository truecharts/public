{{/* Define the exporter container */}}
{{- define "penpot.exporter" -}}
image: {{ .Values.exporterImage.repository }}:{{ .Values.exporterImage.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'

podSecurityContext:
  runAsGroup: 568
  runAsUser: 568

securityContext:
  readOnlyRootFilesystem: false
  runAsNonRoot: true

env:
  - name: 'PENPOT_PUBLIC_URI'
    value: {{ .Values.penpot.public_uri | quote }}
{{- end }}
