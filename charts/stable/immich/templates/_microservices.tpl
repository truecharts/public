{{- define "immich.microservices" -}}
{{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
{{- $serverUrl := printf "http://%v:%v/api/server/ping" $fname .Values.service.main.ports.main.port }}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{/* Wait for server */}}
      {{- include "immich.wait" (dict "url" $serverUrl) | nindent 6 }}
  containers:
    microservices:
      enabled: true
      primary: true
      imageSelector: image
      securityContext:
        capabilities:
          disableS6Caps: true
      envFrom:
        - secretRef:
            name: deps-secret
        - configMapRef:
            name: common-config
        - configMapRef:
            name: micro-config
      probes:
        readiness:
          enabled: true
          type: exec
          command: /usr/src/app/server/bin/immich-healthcheck
        liveness:
          enabled: true
          type: exec
          command: /usr/src/app/server/bin/immich-healthcheck
        startup:
          enabled: true
          type: exec
          command: /usr/src/app/server/bin/immich-healthcheck
{{- end -}}
