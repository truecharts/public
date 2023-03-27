{{/* Define the web container */}}
{{- define "immich.web" -}}
enabled: true
imageSelector: webImage
imagePullPolicy: {{ .Values.webImage.pullPolicy }}
command:
  - /bin/sh
  - ./entrypoint.sh
envFrom:
  - configMapRef:
      name: 'common-config'
probes:
  readiness:
    path: /
    port: 3000
  liveness:
    path: /
    port: 3000
  startup:
    path: /
    port: 3000
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
