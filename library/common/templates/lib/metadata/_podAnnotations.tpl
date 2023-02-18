{{/* Annotations that are added to podSpec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.podAnnotations" $ }}
*/}}
{{- define "tc.v1.common.lib.metadata.podAnnotations" -}}
rollme: {{ randAlphaNum 5 | quote }}
{{- end -}}
