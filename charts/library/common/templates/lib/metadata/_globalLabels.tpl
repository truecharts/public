{{/* Returns the global labels */}}
{{- define "tc.v1.common.lib.metadata.globalLabels" -}}

  {{- include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" .Values.global.labels) -}}

{{- end -}}
