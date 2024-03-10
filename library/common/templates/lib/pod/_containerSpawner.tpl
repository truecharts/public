{{/* Containers */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.containerSpawner" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.containerSpawner" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- include "tc.v1.common.lib.container.primaryValidation" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}

  {{- range $containerName, $containerValues := $objectData.podSpec.containers -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $rootCtx "objectData" $containerValues
                    "name" $containerName "caller" "Container"
                    "key" "containers")) -}}

    {{- if eq $enabled "true" -}}
      {{- $container := (mustDeepCopy $containerValues) -}}
      {{- $name := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
      {{- if not $container.primary -}}
        {{- $name = printf "%s-%s" $name $containerName  -}}
      {{- end -}}

      {{- $_ := set $container "name" $name -}}
      {{- $_ := set $container "shortName" $containerName -}}
      {{- $_ := set $container "podShortName" $objectData.shortName -}}
      {{- $_ := set $container "podPrimary" $objectData.primary -}}
      {{- $_ := set $container "podType" $objectData.type -}}
      {{/* Created from the pod.securityContext, used by fixedEnv */}}
      {{- $_ := set $container "calculatedFSGroup" $objectData.podSpec.calculatedFSGroup -}}
      {{- include "tc.v1.common.lib.pod.container" (dict "rootCtx" $rootCtx "objectData" $container) | trim | nindent 0 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
