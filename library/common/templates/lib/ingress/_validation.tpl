{{/* Ingress Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.ingress.validation" (dict "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The ingress object.
*/}}

{{- define "tc.v1.common.lib.ingress.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}


{{- end -}}
