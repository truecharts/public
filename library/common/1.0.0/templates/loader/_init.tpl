{{- define "ix.v1.common.loader.init" -}}
  {{- /* Merge the local chart values and the common chart defaults */ -}}
  {{- include "ix.v1.common.values.init" . -}}

  {{- include "ix.v1.common.loader.lists" . -}}
{{- end -}}
