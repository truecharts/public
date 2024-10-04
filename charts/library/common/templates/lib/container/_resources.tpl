{{/* Returns Resources */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.resources" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.resources" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $resources := mustDeepCopy $rootCtx.Values.resources -}}

  {{- if $objectData.resources -}}
    {{- $resources = mustMergeOverwrite $resources $objectData.resources -}}
  {{- end -}}

  {{/* We use the objectData instead of $resources,
    as we only allow this flag on the container level */}}
  {{- if not (hasKey $objectData "resources") -}}
    {{- $_ := set $objectData "resources" dict -}}
  {{- end -}}
  {{- if not (hasKey $objectData.resources "excludeExtra") -}}
    {{- $_ := set $objectData.resources "excludeExtra" false -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.container.resources.validation" (dict "resources" $resources) }}
requests:
  cpu: {{ $resources.requests.cpu }}
  memory: {{ $resources.requests.memory }}
  {{- if $resources.limits }}
limits:
    {{- with $resources.limits.cpu }} {{/* Passing 0, will not render it, meaning unlimited */}}
  cpu: {{ . }}
    {{- end -}}
    {{- with $resources.limits.memory }} {{/* Passing 0, will not render it, meaning unlimited */}}
  memory: {{ . }}
    {{- end -}}
    {{- if not $objectData.resources.excludeExtra -}}
      {{- range $k, $v := (omit $resources.limits "cpu" "memory") }} {{/* Omit cpu and memory, as they are handled above */}}
        {{- if or (not $v) (eq (toString $v) "0") -}}
          {{ continue }}
        {{- end }}
  {{ $k }}: {{ $v }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/* Validates resources to match a pattern */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.resources.validation" (dict "resources" $resources) }}
rootCtx: The root context of the chart.
resources: The resources object
*/}}
{{- define "tc.v1.common.lib.container.resources.validation" -}}
  {{- $resources := .resources -}}
  {{/* CPU: https://regex101.com/r/D4HouI/1 */}}
  {{/* MEM: https://regex101.com/r/NNPV2D/1 */}}
  {{- $regex := (dict
                "cpu" "^(0\\.[1-9]|[1-9][0-9]*)(\\.[0-9]|m?)$"
                "memory" "^[1-9][0-9]*([EPTGMK]i?|e[0-9]+)?$") -}}
  {{- $errorMsg := (dict
                    "cpu" "(Plain Integer - eg. 1), (Float - eg. 0.5), (Milicpu - eg. 500m)"
                    "memory" "(Suffixed with E/P/T/G/M/K - eg. 1G), (Suffixed with Ei/Pi/Ti/Gi/Mi/Ki - eg. 1Gi), (Plain Integer in bytes - eg. 1024), (Exponent - eg. 134e6)") -}}

  {{- $resourceTypes := (list "cpu" "memory") -}}

  {{- range $category := (list "requests") -}} {{/* We can also add "limits" here if we want to require them */}}
    {{- if not (get $resources $category) -}}
      {{- fail (printf "Container - Expected non-empty [resources.%s]" $category) -}}
    {{- end -}}

    {{- range $type := $resourceTypes -}}
      {{- if not (get (get $resources $category) $type) -}}
        {{- fail (printf "Container - Expected non-empty [resources.%s.%s]" $category $type) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- range $key := (list "requests" "limits") -}}
    {{- $resourceCategory := (get $resources $key) -}}
    {{- if $resourceCategory -}}

      {{- range $type := $resourceTypes -}}
        {{- $resourceValue := (get $resourceCategory $type) -}}
        {{- if $resourceValue -}} {{/* Only try to match defined values */}}
          {{- if not (mustRegexMatch (get $regex $type) (toString $resourceValue)) -}}
            {{- fail (printf "Container - Expected [resources.%s.%s] to have one of the following formats [%s], but got [%s]" $key $type (get $errorMsg $type) $resourceValue) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.resources.hasGPU" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $gpuType := .gpuType -}}

  {{- $types := (list "nvidia.com/gpu" "amd.com/gpu" "gpu.intel.com/i915") -}}
  {{- if $gpuType -}}
    {{- $types = (list $gpuType) -}}
  {{- end -}}

  {{- $gpu := false -}}

  {{- if and ($rootCtx.Values.resources) ($rootCtx.Values.resources.limits) -}}
    {{- range $t := $types -}}
      {{- if gt ((get $rootCtx.Values.resources.limits $t) | int) 0 -}}
        {{- $gpu = true -}}
        {{- break -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $objectData.podSpec -}}
    {{- range $k, $v := $objectData.podSpec.containers -}}
      {{- if not $v.enabled -}}
        {{- continue -}}
      {{- end -}}

      {{- range $t := $types -}}
        {{- if eq (include "tc.v1.common.lib.container.resources.hasGPU" (dict "rootCtx" $rootCtx "objectData" $v "gpuType" $t)) "true" -}}
          {{- $gpu = true -}}
          {{- break -}}
        {{- end -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}

  {{- $gpu | toString -}}
{{- end -}}

{{- define "tc.v1.common.lib.container.resources.hasGPU" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $gpuType := .gpuType -}}

  {{- $gpu := false -}}

  {{- if and ($objectData.resources) ($objectData.resources.limits) -}}
    {{- if gt ((get $objectData.resources.limits $gpuType) | int) 0 -}}
      {{- $gpu = true -}}
    {{- end -}}
  {{- end -}}

  {{- $gpu | toString -}}
{{- end -}}
