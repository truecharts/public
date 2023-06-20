{{/* Define the machinelearning container */}}
{{- define "immich.machinelearning" -}}
{{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
{{- $url := printf "http://%v-server:%v/server-info/ping" $fname .Values.service.server.ports.server.port }}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{- include "immich.wait" (dict "url" $url) | nindent 6 }}
  containers:
    machinelearning:
      enabled: true
      primary: true
      imageSelector: mlImage
      envFrom:
        - configMapRef:
            name: ml-config
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
