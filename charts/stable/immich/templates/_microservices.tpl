{{- define "immich.microservices" -}}
{{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
{{- $serverUrl := printf "http://%v:%v/api/server-info/ping" $fname .Values.service.main.ports.main.port }}
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
      command: /bin/sh
      args:
        - -c
        - /usr/src/app/start-microservices.sh
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
          type: tcp
          port: {{ .Values.service.microservices.ports.microservices.port }}
        liveness:
          enabled: true
          type: tcp
          port: {{ .Values.service.microservices.ports.microservices.port }}
        startup:
          enabled: true
          type: tcp
          port: {{ .Values.service.microservices.ports.microservices.port }}
{{- end -}}
