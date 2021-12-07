{{/*
Common workload annotations
*/}}
{{- define "common.annotations" -}}
rollme: {{ randAlphaNum 5 | quote }}
{{- end -}}
