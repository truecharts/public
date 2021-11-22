{{- define "common.setup" -}}

{{- /* Merge the local chart values and the common chart defaults */ -}}
{{- include "common.values" . }}

{{- /* Autogenerate postgresql passwords if needed */ -}}
{{- include "common.dependencies.postgresql.injector" . }}

{{- /* Autogenerate redis passwords if needed */ -}}
{{- include "common.dependencies.redis.injector" . }}

{{- /* Autogenerate mariadb passwords if needed */ -}}
{{- include "common.dependencies.mariadb.injector" . }}
{{- end -}}
