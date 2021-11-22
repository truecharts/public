{{- define "common.setup" -}}

{{- /* Merge the local chart values and the common chart defaults */ -}}
{{- include "common.values" . }}

{{- /* Add Bitnami value translator*/ -}}
{{- include "common.images.image" . }}
{{- include "common.images.pullSecrets" . }}
{{- include "common.images.renderPullSecrets" . }}

{{- /* Autogenerate postgresql passwords if needed */ -}}
{{- include "common.dependencies.postgresql.injector" . }}

{{- /* Autogenerate redis passwords if needed */ -}}
{{- include "common.dependencies.redis.injector" . }}

{{- /* Autogenerate mariadb passwords if needed */ -}}
{{- include "common.dependencies.mariadb.injector" . }}
{{- end -}}
