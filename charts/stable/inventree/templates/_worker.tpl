{{/* Define the worker container */}}
{{- define "inventree.worker" -}}
enabled: true
imageSelector: image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
command: ["invoke", "worker"]
envFrom:
  - secretRef:
      name: 'inventree-secret'
  - configMapRef:
      name: 'inventree-config'
{{- end -}}
