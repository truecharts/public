{{/* Returns Lowest and Highest ports assigned to the any container in the pod */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.helpers.securityContext.getPortRange" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.helpers.securityContext.getPortRange" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{ $portRange := (dict "high" 0 "low" 0) }}

  {{- range $name, $service := $rootCtx.Values.service -}}
    {{- $selected := false -}}
    {{/* If service is enabled... */}}
    {{- if $service.enabled -}}

      {{/* If there is a selector */}}
      {{- if $service.targetSelector -}}

        {{/* And pod is selected */}}
        {{- if eq $service.targetSelector $objectData.shortName -}}
          {{- $selected = true -}}
        {{- end -}}

      {{- else -}}
        {{/* If no selector is defined but pod is primary */}}
        {{- if $objectData.primary -}}
          {{- $selected = true -}}
        {{- end -}}

      {{- end -}}
    {{- end -}}

    {{- if $selected -}}
      {{- range $name, $portValues := $service.ports -}}
        {{- if $portValues.enabled -}}

          {{- $portToCheck := ($portValues.targetPort | default $portValues.port) -}}
          {{- if kindIs "string" $portToCheck -}}
            {{- $portToCheck = (tpl $portToCheck $rootCtx) | int -}}
          {{- end -}}

          {{- if or (not $portRange.low) (lt ($portToCheck | int) ($portRange.low | int)) -}}
            {{- $_ := set $portRange "low" $portToCheck -}}
          {{- end -}}

          {{- if or (not $portRange.high) (gt ($portToCheck | int) ($portRange.high | int)) -}}
            {{- $_ := set $portRange "high" $portToCheck -}}
          {{- end -}}

        {{- end -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}

  {{- $portRange | toJson -}}
{{- end -}}
