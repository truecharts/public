{{/* Service - ExternalIP Spec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.spec.externalIP" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The service object data
*/}}

{{- define "tc.v1.common.lib.service.spec.externalIP" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}

publishNotReadyAddresses: {{ include "tc.v1.common.lib.service.publishNotReadyAddresses" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim }}
  {{- with (include "tc.v1.common.lib.service.externalIPs" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
externalIPs:
    {{- . | nindent 2 }}
  {{- end -}}
  {{- include "tc.v1.common.lib.service.sessionAffinity" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
  {{- include "tc.v1.common.lib.service.externalTrafficPolicy" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
{{- end -}}
