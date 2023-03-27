{{/* Define the ml container */}}
{{- define "immich.microservices" -}}
enabled: true
imageSelector: image
imagePullPolicy: {{ .Values.image.pullPolicy }}
command:
  - /bin/sh
  - ./start-microservices.sh
envFrom:
  - secretRef:
      name: 'secret'
  - configMapRef:
      name: 'common-config'
  - configMapRef:
      name: 'server-config'
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
probes:
  readiness:
    exec:
      command:
        - /bin/sh
        - -c
        - |
          ps -a | grep -v grep | grep -q microservices || exit 1
  liveness:
    exec:
      command:
        - /bin/sh
        - -c
        - |
          ps -a | grep -v grep | grep -q microservices || exit 1
  startup:
    exec:
      command:
        - /bin/sh
        - -c
        - |
          ps -a | grep -v grep | grep -q microservices || exit 1
{{- end -}}
