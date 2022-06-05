{{/* vim: set filetype=mustache: */}}
{{/*
Warning about using rolling tag.
Usage:
{{ include "tc.common.warnings.rollingTag" .Values.path.to.the.imageRoot }}
*/}}
{{- define "tc.common.warnings.rollingTag" -}}

{{- if not (.tag | toString | regexFind "-r\\d+$|sha256:") }}
WARNING: Rolling tag detected ({{ .repository }}:{{ .tag }}), please note that it is strongly recommended to avoid using rolling tags in a production environment.
+info https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/
{{- end }}

{{- end -}}
