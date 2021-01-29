{{/*
Determine secret name.
*/}}
{{- define "minio.secretName" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}


{{/*
Properly format optional additional arguments to Minio binary
*/}}
{{- define "minio.extraArgs" -}}
{{- range .Values.extraArgs -}}
{{ " " }}{{ . }}
{{- end -}}
{{- end -}}
