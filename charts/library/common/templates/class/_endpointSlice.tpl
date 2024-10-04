{{/* EndpointSlice Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.endpointSlice" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData: The service data, that will be used to render the Service object.
*/}}

{{- define "tc.v1.common.class.endpointSlice" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $addressType := $objectData.addressType | default "IPv4" -}}
  {{- if $objectData.addressType -}}
    {{- $addressType = tpl $addressType $rootCtx -}}
    {{- $validTypes := (list "IPv4" "IPv6" "FQDN") -}}
    {{- if not (mustHas $addressType $validTypes) -}}
      {{- fail (printf "EndpointSlice - Expected [addressType] to be one of [%s], but got [%s]" (join ", " $validTypes) $addressType) -}}
    {{- end -}}
  {{- end }}

---
apiVersion: discovery.k8s.io/v1
kind: EndpointSlice
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Endpoint Slice") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- $_ := set $labels "kubernetes.io/service-name" $objectData.name -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
addressType: {{ $addressType }}
ports:
{{- include "tc.v1.common.lib.endpointslice.ports" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 }}
endpoints:
{{- include "tc.v1.common.lib.endpointslice.endpoints" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 }}
{{- end -}}
