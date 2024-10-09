{{/* Returns the global annotations */}}
{{- define "tc.v1.common.lib.metadata.globalAnnotations" -}}

  {{- include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" .Values.global.annotations) -}}

{{- end -}}
