{{/*
Main entrypoint for the common library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "common.all" -}}
  {{- /* Generate chart and dependency values */ -}}
  {{- include "common.setup" . }}

  {{- /* Generate remaining objects */ -}}
  {{- include "common.postSetup" . }}

{{- end -}}
