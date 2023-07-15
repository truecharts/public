{{/* Define the exportarr container */}}
{{- define "sonarr.exportarr" -}}
enabled: true
type: Deployment
podSpec:
  containers:
    exportarr:
      enabled: true
      primary: true
      imageSelector: exportarrImage
      args:
        - sonarr
      envFrom:
        - configMapRef:
            name: exportarr-config
      probes:
        readiness:
          enabled: true
          type: http
          path: /exportarr
          port: {{ .Values.service.exportarr.ports.exportarr.port }}
        liveness:
          enabled: true
          type: http
          path: /metrics
          port: {{ .Values.service.exportarr.ports.exportarr.port }}
        startup:
          enabled: true
          type: http
          path: /metrics
          port: {{ .Values.service.exportarr.ports.exportarr.port }}
{{- end -}}
