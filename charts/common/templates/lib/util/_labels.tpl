{{/* vim: set filetype=mustache: */}}
{{/*
Kubernetes standard labels
*/}}
{{- define "tc.common.labels.standard" -}}
{{- include "tc.common.labels" . }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "tc.common.labels.matchLabels" -}}
{{- include "tc.common.labels.selectorLabels" . }}
{{- end -}}
