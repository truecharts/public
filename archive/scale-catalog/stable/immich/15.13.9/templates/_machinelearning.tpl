{{/* Define the machinelearning container */}}
{{- define "immich.machinelearning" -}}
{{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
{{- $serverUrl := printf "http://%v:%v/api/server-info/ping" $fname .Values.service.main.ports.main.port }}
{{- $img := "mlImage" -}}
{{- with .Values.immich.mlImageType -}}
  {{- $img = . -}}
{{- end }}
enabled: true
type: Deployment
podSpec:
  initContainers:
    wait-server:
      {{/* Wait for server */}}
      {{- include "immich.wait" (dict "url" $serverUrl) | nindent 6 }}
  containers:
    machinelearning:
      enabled: true
      primary: true
      imageSelector: {{ $img }}
      securityContext:
        capabilities:
          disableS6Caps: true
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
