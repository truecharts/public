{{- define "immich.microservices" -}}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{- include "immich.wait" (dict "variable" "IMMICH_SERVER_URL" "path" "server-info/ping") | nindent 6 }}
  containers:
    microservices:
      enabled: true
      primary: true
      imageSelector: image
      command: /bin/sh
      args: ./start-microservices.sh
      envFrom:
        - secretRef:
            name: secret
        - secretRef:
            name: deps-secret
        - configMapRef:
            name: common-config
        - configMapRef:
            name: server-config
        - configMapRef:
            name: micro-config
      probes:
        readiness:
          enabled: true
          type: exec
          command:
            - /bin/sh
            - -c
            - |
              ps -a | grep -v grep | grep -q microservices
        liveness:
          enabled: true
          type: exec
          command:
            - /bin/sh
            - -c
            - |
              ps -a | grep -v grep | grep -q microservices
        startup:
          enabled: true
          type: exec
          command:
            - /bin/sh
            - -c
            - |
              ps -a | grep -v grep | grep -q microservices
{{- end -}}

{{- define "immich.microservices.service" -}}
enabled: true
type: ClusterIP
targetSelector: microservices
ports:
  microservices:
    enabled: true
    primary: true
    port: 10004
    protocol: http
    targetSelector: microservices
{{- end -}}
