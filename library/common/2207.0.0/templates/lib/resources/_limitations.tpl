{{/*
    Resource limitations
*/}}
{{ define "common.resources.limitation" }}
{{ if (or .Values.enableResourceLimits .Values.gpuConfiguration) }}
resources:
  limits:
{{ if .Values.enableResourceLimits }}
    cpu: {{ .Values.cpuLimit }}
    memory: {{ .Values.memLimit }}
{{ end }}
{{ if .Values.gpuConfiguration }}
    {{ toYaml .Values.gpuConfiguration | nindent 4 }}
{{ end }}
{{ end }}
{{ end }}
