{{/* Annotations that are added to all objects */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.allAnnotations" $ }}
*/}}
{{- define "tc.v1.common.lib.metadata.allAnnotations" -}}
  {{/* Currently empty but can add later, if needed */}}
{{- include "tc.v1.common.lib.metadata.globalAnnotations" . }}

{{- end -}}
