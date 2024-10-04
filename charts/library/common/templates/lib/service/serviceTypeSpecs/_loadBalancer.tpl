{{/* Service - LoadBalancer Spec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.spec.loadBalancer" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The service object data
*/}}

{{- define "tc.v1.common.lib.service.spec.loadBalancer" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}

type: LoadBalancer
allocateLoadBalancerNodePorts: {{ $objectData.allocateLoadBalancerNodePorts | default false }}
publishNotReadyAddresses: {{ include "tc.v1.common.lib.service.publishNotReadyAddresses" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim }}
  {{- with (include "tc.v1.common.lib.service.externalIPs" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
externalIPs:
    {{- . | nindent 2 }}
  {{- end -}}
  {{- with $objectData.loadBalancerSourceRanges }}
loadBalancerSourceRanges:
    {{- range . }}
  - {{ tpl . $rootCtx }}
    {{- end -}}
  {{- end -}}
  {{- include "tc.v1.common.lib.service.clusterIP" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
  {{- include "tc.v1.common.lib.service.ipFamily" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
  {{- include "tc.v1.common.lib.service.externalTrafficPolicy" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
  {{- include "tc.v1.common.lib.service.sessionAffinity" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
{{- end -}}
