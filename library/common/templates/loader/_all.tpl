{{/*
Main entrypoint for the common library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "ix.v1.common.loader.all" -}}
  {{- /* Generate chart and dependency values */ -}}
  {{- include "ix.v1.common.loader.init" . }}

  {{- /* Generate remaining objects */ -}}
  {{- include "ix.v1.common.loader.apply" . }}
{{- end -}}
