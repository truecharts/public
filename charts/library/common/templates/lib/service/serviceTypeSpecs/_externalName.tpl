{{/* Service - ExternalName Spec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.spec.externalName" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The service object data
*/}}

{{- define "tc.v1.common.lib.service.spec.externalName" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}

  {{- if not $objectData.externalName -}}
    {{- fail "Service - Expected non-empty [externalName] on ExternalName service type." -}}
  {{- end }}

type: ExternalName
externalName: {{ tpl $objectData.externalName $rootCtx }}
publishNotReadyAddresses: {{ include "tc.v1.common.lib.service.publishNotReadyAddresses" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim }}
  {{- with (include "tc.v1.common.lib.service.externalIPs" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
externalIPs:
    {{- . | nindent 2 }}
  {{- end }}
  {{- include "tc.v1.common.lib.service.sessionAffinity" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
  {{- include "tc.v1.common.lib.service.clusterIP" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
  {{- include "tc.v1.common.lib.service.externalTrafficPolicy" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
{{- end -}}
