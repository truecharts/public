{{/*
Retrieve image configuration for container
*/}}
{{- define "common.containers.imageConfig" -}}
{{- $values := . -}}
{{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "repository" "tag" "pullPolicy")) -}}
image: "{{ $values.repository }}:{{ $values.tag }}"
imagePullPolicy: {{ $values.pullPolicy }}
{{- end -}}
