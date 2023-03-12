{{/* Define the ml container */}}
{{- define "immich.microservices" -}}
enabled: true
imageSelector: image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
command:
  - /bin/sh
  - ./start-microservices.sh
envFrom:
  - secretRef:
      name: 'immich-secret'
  - configMapRef:
      name: 'common-config'
  - configMapRef:
      name: 'server-config'
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
