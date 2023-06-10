{{/* Define the configmap */}}
{{- define "frigate.configmap" -}}
enabled: true
data:
  config.yml: |
    {{- .Values.frigateConfig | toYaml | nindent 4 }}
{{- end -}}

{{- define "frigate.configVolume" -}}
  {{- if and (not .Values.frigate.configFileHostPath) (not .Values.frigateConfig) -}}
    {{- fail "Frigate - Ony one of [configFileHostPath, frigateConfig] can be defined" -}}
  {{- end }}

enabled: true
{{- if .Values.frigateConfig }}
type: configmap
objectName: frigate-config
mountPath: /config
items:
  - key: config.yml
    path: config.yml
{{- else if .Values.frigate.configFileHostPath }}
type: hostPath
hostPathType: File
hostPath: {{ .Values.frigate.configFileHostPath }}
mountPath: /config/config.yml
{{- else -}}
  {{- fail "Frigate - One of [configFileHostPath, frigateConfig] must be defined" -}}
{{- end -}}
{{- end -}}
