{{/*
Determine secret name.
*/}}
{{- define "minio.secretName" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}
