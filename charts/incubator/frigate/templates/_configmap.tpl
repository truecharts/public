{{/* Define the configmap */}}
{{- define "frigate.configmap" -}}
enabled: true
data:
  {{- if .Values.frigateConfig }}
  config.yml: |
    {{- .Values.frigateConfig | toYaml | nindent 4 }}
  {{- else }}
  config.yml.default: |
    mqtt:
      enabled: false
    cameras:
      dummy:
        enabled: false
        ffmpeg:
          inputs:
            - path: rtsp://127.0.0.1:554/rtsp
              roles:
                - detect
  {{- end }}
{{- end -}}

{{- define "frigate.configVolume" -}}
enabled: true
type: configmap
objectName: frigate-config
mountPath: /config
targetSelector:
  main:
    main: {}
    init-config: {}
items:
{{- if .Values.frigateConfig }}
  - key: config.yml
    path: config.yml
{{- else  }}
  - key: config.yml.default
    path: config.yml.default
{{- end -}}
{{- end -}}
