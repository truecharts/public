{{/* Define the worker container */}}
{{- define "inventree.worker" -}}
enabled: true
imageSelector: image
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
command: ["invoke", "worker"]
envFrom:
  - secretRef:
      name: 'secrets'
  - configMapRef:
      name: 'config'
probes:
  startup:
    enabled: false
  readyness:
    enabled: false
  liveness:
    enabled: false
env:
  INVENTREE_DB_PASSWORD:
    secretKeyRef:
      name: cnpg-main-user
      key: password
  INVENTREE_DB_HOST:
    secretKeyRef:
      name: cnpg-main-urls
      key: plainporthost
{{- end -}}
