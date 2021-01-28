{{/*
Retrieve volume configuration
*/}}
{{- define "common.volumeConfig" -}}
{{- $values := . -}}
{{- if hasKey $values "name" }}
- name: {{ $values.name }}
{{- if $values.emptyDirVolumes -}}
  emptyDir: {}
{{- else -}}
  hostPath:
    path: {{ template "common.configuredHostPath" $values }}
{{- end -}}
{{- else -}}
{{- fail "Name must be specified for Volume Configuration" -}}
{{- end -}}
{{- end -}}
