{{/* Metadata Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" $caller) -}}
objectData:
  labels: The labels of the configmap.
  annotations: The annotations of the configmap.
  data: The data of the configmap.
*/}}

{{- define "tc.v1.common.lib.metadata.validation" -}}
  {{- $objectData := .objectData -}}
  {{- $caller := .caller -}}

  {{- if and $objectData.labels (not (kindIs "map" $objectData.labels)) -}}
    {{- fail (printf "%s - Expected [labels] to be a dictionary, but got [%v]" $caller (kindOf $objectData.labels)) -}}
  {{- end -}}

  {{- if and $objectData.annotations (not (kindIs "map" $objectData.annotations)) -}}
    {{- fail (printf "%s - Expected [annotations] to be a dictionary, but got [%v]" $caller (kindOf $objectData.annotations)) -}}
  {{- end -}}

{{- end -}}
