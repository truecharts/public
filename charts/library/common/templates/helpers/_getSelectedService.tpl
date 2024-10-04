{{/* Service - Get Selected Service */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.helpers.getSelectedServiceValues" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
objectData: The object data of the service
rootCtx: The root context of the chart.
*/}}

{{- define "tc.v1.common.lib.helpers.getSelectedServiceValues" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $caller := .caller -}}

  {{- $serviceValues := dict -}}
  {{- with $objectData.targetSelector -}}
    {{- $serviceValues = mustDeepCopy (get $rootCtx.Values.service .) -}}

    {{- if not $serviceValues -}}
      {{- fail (printf "%s - Selected service [%s] is not defined" $caller .) -}}
    {{- end -}}

    {{- if not $serviceValues.enabled -}}
      {{- fail (printf "%s - Selected service [%s] is not enabled" $caller .) -}}
    {{- end -}}

    {{/* While we know the shortName from targetSelector, let's set it explicitly
    So service can reference this directly, to match the behaviour of a service
    without targetSelector defined (assumes "use primary") */}}
    {{- $_ := set $serviceValues "shortName" . -}}
  {{- else -}}

    {{/* If no targetSelector is defined, we assume the service is using the primary service */}}
    {{/* Also no need to check for multiple primaries here, it's already done on the service validation */}}
    {{- range $serviceName, $service := $rootCtx.Values.service -}}
      {{- if $service.enabled -}}
        {{- if $service.primary -}}
          {{- $serviceValues = mustDeepCopy $service -}}
          {{/* Set the shortName so service can use this on selector */}}
          {{- $_ := set $serviceValues "shortName" $serviceName -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}

  {{/* Return values in Json, to preserve types */}}
  {{ $serviceValues | toJson }}
{{- end -}}
