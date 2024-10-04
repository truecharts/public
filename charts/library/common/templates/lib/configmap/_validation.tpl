{{/* Configmap Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.configmap.validation" (dict "objectData" $objectData) -}}
objectData:
  labels: The labels of the configmap.
  annotations: The annotations of the configmap.
  data: The data of the configmap.
*/}}

{{- define "tc.v1.common.lib.configmap.validation" -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.data -}}
    {{- fail "ConfigMap - Expected non-empty [data]" -}}
  {{- end -}}

  {{- if not (kindIs "map" $objectData.data) -}}
    {{- fail (printf "ConfigMap - Expected [data] to be a dictionary, but got [%v]" (kindOf $objectData.data)) -}}
  {{- end -}}

{{- end -}}
