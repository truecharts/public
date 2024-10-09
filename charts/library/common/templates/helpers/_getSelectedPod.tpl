{{/* Service - Get Selected Pod */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.helpers.getSelectedPodValues" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
objectData: The object data of the service
rootCtx: The root context of the chart.
*/}}

{{- define "tc.v1.common.lib.helpers.getSelectedPodValues" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $caller := .caller -}}

  {{- $podValues := dict -}}
  {{- with $objectData.targetSelector -}}
    {{- $podValues = mustDeepCopy (get $rootCtx.Values.workload .) -}}

    {{- if not $podValues -}}
      {{- fail (printf "%s - Selected pod [%s] is not defined" $caller .) -}}
    {{- end -}}

    {{- if not $podValues.enabled -}}
      {{- fail (printf "%s - Selected pod [%s] is not enabled" $caller .) -}}
    {{- end -}}

    {{/* While we know the shortName from targetSelector, let's set it explicitly
    So service can reference this directly, to match the behaviour of a service
    without targetSelector defined (assumes "use primary") */}}
    {{- $_ := set $podValues "shortName" . -}}
  {{- else -}}

    {{/* If no targetSelector is defined, we assume the service is using the primary pod */}}
    {{/* Also no need to check for multiple primaries here, it's already done on the workload validation */}}
    {{- range $podName, $pod := $rootCtx.Values.workload -}}
      {{- if $pod.enabled -}}
        {{- if $pod.primary -}}
          {{- $podValues = mustDeepCopy $pod -}}
          {{/* Set the shortName so service can use this on selector */}}
          {{- $_ := set $podValues "shortName" $podName -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}

  {{/* Return values in Json, to preserve types */}}
  {{ $podValues | toJson }}
{{- end -}}
