{{/*
Main entrypoint for the common library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "tc.common.loader.all" -}}
  {{/* Generate chart and dependency values */}}
  {{- include "tc.common.loader.init" . }}

  {{/* Generate remaining objects */}}
  {{- include "tc.common.loader.apply" . }}

{{- end -}}
