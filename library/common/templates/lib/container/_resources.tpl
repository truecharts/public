{{/* Returns Resources */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.resources" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.resources" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $resources := $rootCtx.Values.resources -}}

  {{- if $objectData.resources -}}
    {{- $resources = mustMergeOverwrite $resources $objectData.resources -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.container.resources.validation" (dict "resources" $resources) -}}

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
    {{- include "tc.v1.common.lib.container.resources.gpu" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
  {{- end -}}
{{- end -}}

{{/* Returns GPU resource */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.resources.gpu" (dict "rootCtx" $rootCtx "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.resources.gpu" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $returnBool := .returnBool -}}

  {{- $gpuResource := list -}}

  {{- range $GPUValues := $rootCtx.Values.scaleGPU -}}
    {{- if not $GPUValues.gpu -}}
      {{- fail "Container - Expected non-empty <scaleGPU.gpu>" -}}
    {{- end -}}

    {{- $selected := false -}}

    {{/* Parse selector if defined */}}
    {{- if $GPUValues.targetSelector -}}
      {{- range $podName, $containers := $GPUValues.targetSelector -}}
        {{- if not $containers -}}
          {{- fail "Container - Expected non-empty list under pod in <scaleGPU.targetSelector>" -}}
        {{- end -}}

        {{- if and (eq $podName $objectData.podShortName) (mustHas $objectData.shortName $containers) -}}
          {{- $selected = true -}}
        {{- end -}}
      {{- end -}}
    {{/* If no selector, select primary pod/container */}}
    {{- else if and $objectData.podPrimary $objectData.primary -}}
      {{- $selected = true -}}
    {{- end -}}

    {{- if $selected -}}
      {{- $gpuResource = mustAppend $gpuResource $GPUValues.gpu -}}
    {{- end -}}
  {{- end -}}

  {{- if not $returnBool -}}
    {{- range $gpu := $gpuResource -}}
      {{- range $k, $v := $gpu -}}
        {{- if or (kindIs "invalid" $v) (eq (toString $v) "") -}}
          {{- fail "Container - Expected non-empty <scaleGPU> <value>" -}}
        {{- end -}} {{/* Don't try to schedule 0 GPUs */}}
        {{- if gt (int $v) 0 }}
{{ $k }}: {{ $v | quote }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- else -}}
    {{- if $gpuResource -}}
      {{- "true" -}}
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
      {{- fail (printf "Container - Expected non-empty <resources.%s>" $category) -}}
    {{- end -}}

    {{- range $type := $resourceTypes -}}
      {{- if not (get (get $resources $category) $type) -}}
        {{- fail (printf "Container - Expected non-empty <resources.%s.%s>" $category $type) -}}
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
            {{- fail (printf "Container - Expected <resources.%s.%s> to have one of the following formats [%s], but got [%s]" $key $type (get $errorMsg $type) $resourceValue) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
