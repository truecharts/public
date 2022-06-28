{{/*
Retrieve GPU Configuration
*/}}
{{- define "common.containers.gpuConfiguration" -}}
{{- $values := . -}}
{{ if $values.gpuConfiguration }}
resources:
  limits: {{- toYaml $values.gpuConfiguration | nindent 4 }}
{{ end }}
{{- end -}}
