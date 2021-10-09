{{- define "common.setup" -}}
{{- /* Merge the local chart values and the common chart defaults */ -}}
{{- include "common.values" . }}

{{- /* Autogenerate postgresql passwords if needed */ -}}
{{- include "common.dependencies.postgresql.injector" . }}
{{- end -}}
