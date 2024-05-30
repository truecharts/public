{{/* Define the configmap */}}
{{- define "frigate.configmap" -}}
enabled: true
data:
  config.yml: |
  {{- if .Values.frigateConfig }}
    {{- .Values.frigateConfig | toYaml | nindent 4 }}
  {{- else }}
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
{{- $mountPath := "/dummy-config/config.yml" -}}
{{- if .Values.frigateConfig }}
  {{- $mountPath = "/config/config.yaml" -}}
{{- end }}
enabled: true
type: configmap
objectName: frigate-config
items:
  - key: config.yml
    path: config.yml
targetSelector:
  main:
    main:
      subPath: config.yml
      mountPath: {{ $mountPath }}
      readOnly: true
    init-config:
      subPath: config.yml
      mountPath: {{ $mountPath }}
      readOnly: true
{{- end -}}
