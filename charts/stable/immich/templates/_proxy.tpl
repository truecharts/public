{{/* Define the proxy container */}}
{{- define "immich.proxy" -}}
enabled: true
imageSelector: proxyImage
imagePullPolicy: {{ .Values.proxyImage.pullPolicy }}
envFrom:
  - configMapRef:
      name: 'common-config'
probes:
  readiness:
    path: /api/server-info/ping
      port: {{ .Values.service.main.ports.main.targetPort }}
  liveness:
    path: /api/server-info/ping
      port: {{ .Values.service.main.ports.main.targetPort }}
  startup:
    path: /api/server-info/ping
      port: {{ .Values.service.main.ports.main.targetPort }}
env:
  DB_PASSWORD:
    secretKeyRef:
      name: cnpg-main-user
      key: password
  DB_HOSTNAME:
    secretKeyRef:
      name: cnpg-main-urls
      key: plainporthost
  REDIS_HOSTNAME:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "rediscreds" }}'
      key: plainhost
  REDIS_PASSWORD:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "rediscreds" }}'
      key: redis-password
{{- end -}}
