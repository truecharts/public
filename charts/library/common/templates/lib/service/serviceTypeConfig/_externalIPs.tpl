{{/* Service - externalIPs */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.externalIPs" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The service object data
*/}}

{{- define "tc.v1.common.lib.service.externalIPs" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- with $objectData.externalIPs -}}
    {{- range . }}
- {{ tpl . $rootCtx }}
    {{- end -}}
  {{- end -}}
{{- end -}}
