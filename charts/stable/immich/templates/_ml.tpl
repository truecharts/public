{{/* Define the ml container */}}
{{- define "immich.ml" -}}
enabled: true
imageSelector: mlImage
imagePullPolicy: {{ .Values.mlImage.pullPolicy }}
command:
  {{- if .Values.persistence.modelcache }}{{/* Only change command after upgrade */}}
  - python
  - src/main.py
  {{- else }}
  - /bin/sh
  - ./entrypoint.sh
  {{- end }}
envFrom:
  - configMapRef:
      name: 'common-config'
  - configMapRef:
      name: 'server-config'
  - secretRef:
      name: 'immich-secret'
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
    enabled: false
  #  exec:
  #    command:
  #      - /bin/sh
  #      - -c
  #      - |
  #        grep -q main.js /proc/1/cmdline || exit 1
  liveness:
    enabled: false
  #  exec:
  #    command:
  #      - /bin/sh
  #      - -c
  #      - |
  #        grep -q main.js /proc/1/cmdline || exit 1
  startup:
    enabled: false
  #  exec:
  #    command:
  #      - /bin/sh
  #      - -c
  #      - |
  #        grep -q main.js /proc/1/cmdline || exit 1

{{- end -}}
