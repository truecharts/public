{{/*
    Resource limitations
*/}}
{{- define "common.resources.limitaion" -}}
{{- if .Values.enableResourceLimits -}}
resources:
  limits:
    cpu: {{ .Values.cpuLimit }}
    memory: {{ .Values.memLimit }}
{{- end -}}
{{- end -}}
