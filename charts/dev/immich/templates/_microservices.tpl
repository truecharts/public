{{- define "immich.microservices" -}}
enabled: true
imageSelector: image
command:
  - /bin/sh
  - ./start-microservices.sh
envFrom:
  - secretRef:
      name: secret
  - secretRef:
      name: deps-secret
  - configMapRef:
      name: common-config
  - configMapRef:
      name: server-config
probes:
  readiness:
    enabled: true
    type: exec
    command:
      - /bin/sh
      - -c
      - |
        ps -a | grep -v grep | grep -q microservices || exit 1
  liveness:
    type: exec
    command:
      - /bin/sh
      - -c
      - |
        ps -a | grep -v grep | grep -q microservices || exit 1
  startup:
    type: exec
    command:
      - /bin/sh
      - -c
      - |
        ps -a | grep -v grep | grep -q microservices || exit 1
{{- end -}}
