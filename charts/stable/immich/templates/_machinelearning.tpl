{{/* Define the machinelearning container */}}
{{- define "immich.machinelearning" -}}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{- include "immich.wait" (dict "variable" "IMMICH_SERVER_URL" "path" "server-info/ping") | nindent 6 }}
  containers:
    machinelearning:
      enabled: true
      primary: true
      imageSelector: mlImage
      envFrom:
        - configMapRef:
            name: common-config
        - configMapRef:
            name: server-config
        - configMapRef:
            name: ml-config
        - secretRef:
            name: deps-secret
        - secretRef:
            name: secret
      probes:
        readiness:
          enabled: true
          type: http
          path: /ping
          port: {{ .Values.service.machinelearning.ports.machinelearning.port }}
        liveness:
          enabled: true
          type: http
          path: /ping
          port: {{ .Values.service.machinelearning.ports.machinelearning.port }}
        startup:
          enabled: true
          type: http
          path: /ping
          port: {{ .Values.service.machinelearning.ports.machinelearning.port }}
{{- end -}}

{{- define "immich.machinelearning.service" -}}
enabled: true
type: ClusterIP
targetSelector: machinelearning
ports:
  machinelearning:
    enabled: true
    primary: true
    port: 10003
    protocol: http
    targetSelector: machinelearning
{{- end -}}
