{{/* Returns the resources for the container */}}
{{- define "ix.v1.common.container.resources" -}}
  {{- $resources := .resources -}}
  {{- $gpu := .gpu -}}
  {{- $isMainContainer := .isMainContainer -}}
  {{- $root := .root -}}

  {{- if and (hasKey $resources "inherit") $isMainContainer -}}
    {{- fail "<resources.inherit> key is only available for additional/init/install/upgrade containers." -}}
  {{- end -}}

  {{/* Get defaults from global */}}
  {{- $defautlResources := $root.Values.global.defaults.resources -}}
  {{- $newResources := (mustDeepCopy $defautlResources) -}}

  {{- if and $resources.inherit (not $isMainContainer) -}} {{/* if inherit is set, overwrite defaults with values from mainContainer */}}
    {{- if (hasKey $root.Values "resources") -}}
      {{- $newResources = mustMergeOverwrite $newResources $root.Values.resources -}}
    {{- end -}}
  {{- end -}}

  {{/* Overwrite from values that user/dev passed on this container */}}
  {{- $newResources = mustMergeOverwrite $newResources $resources -}}

  {{/* Validate Values */}}
  {{- include "ix.v1.common.lib.resources.validate" (dict "key" "cpu"
                                                          "object" "requests"
                                                          "required" true
                                                          "value" $newResources.requests.cpu) -}}
  {{- include "ix.v1.common.lib.resources.validate" (dict "key" "memory"
                                                          "object" "requests"
                                                          "required" true
                                                          "value" $newResources.requests.memory) -}}
  {{- include "ix.v1.common.lib.resources.validate" (dict "key" "cpu"
                                                          "object" "limits"
                                                          "required" false
                                                          "value" $newResources.limits.cpu) -}}
  {{- include "ix.v1.common.lib.resources.validate" (dict "key" "memory"
                                                          "object" "limits"
                                                          "required" false
                                                          "value" $newResources.limits.memory) -}}

  {{- with (include "ix.v1.common.container.resources.cpuAndMemory" (dict "cpu" $newResources.requests.cpu "memory" $newResources.requests.memory)) }}
requests:
    {{- . | indent 2 -}}
  {{- end -}}
  {{- if or $newResources.limits.cpu $newResources.limits.memory $gpu }}
limits:
    {{- include "ix.v1.common.container.resources.cpuAndMemory" (dict "cpu" $newResources.limits.cpu "memory" $newResources.limits.memory) | indent 2 -}}
    {{- include "ix.v1.common.container.resources.gpu" (dict "gpu" $gpu) | indent 2 -}}
  {{- end -}}
{{- end -}}

{{/* Returns CPU and Memory if applicable */}}
{{- define "ix.v1.common.container.resources.cpuAndMemory" -}}
  {{- $cpu := .cpu -}}
  {{- $memory := .memory -}}

  {{- with $cpu }}
cpu: {{ . }}
  {{- end -}}
  {{- with $memory }}
memory: {{ . }}
  {{- end -}}
{{- end -}}

{{/* Returns GPU if applicable */}}
{{- define "ix.v1.common.container.resources.gpu" -}}
  {{- $gpu := .gpu -}}

  {{- range $k, $v := $gpu -}}
    {{- if not $v -}}
      {{- fail (printf "Value is not provided for GPU (<key> %s)" $k) -}}
    {{- else }}
      {{- $k | nindent 0 }}: {{ $v | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/* Validates resources to match a pattern */}}
{{- define "ix.v1.common.lib.resources.validate" -}}
  {{- $key := .key -}}
  {{- $object := .object -}}
  {{- $value := .value -}}
  {{- $required := .required -}}

  {{- with (toString $value) -}} {{/* Stringify to avoid falsy values evaluating as false */}}

    {{- if $required -}} {{/* If requred and it's empty fail (requests are requried) */}}
      {{- if eq . "<nil>" -}}
        {{- fail (printf "<resources.%s.%s> cannot be empty." $object $key) -}}
      {{- end -}}
    {{- end -}}

    {{/* If it's not null validate input */}}
    {{- if ne . "<nil>" -}} {{/* Limits can be null, means "no limit" */}}
      {{- if eq $key "cpu" -}}
        {{/* https://regex101.com/r/D4HouI/1 */}}
        {{- if not (mustRegexMatch "^(0\\.[1-9]|[1-9][0-9]*)(\\.[0-9]|m?)$" .) -}}
          {{- fail (printf "<resources.%s.%s> has invalid format in value (%s). Valid formats are (Plain Integer eg. 1) (Float eg. 0.5) (Milicpu 500m)." $object $key .) -}}
        {{- end -}}

      {{- else if eq $key "memory" -}}
        {{/* https://regex101.com/r/NNPV2D/1 */}}
        {{- if not (mustRegexMatch "^[1-9][0-9]*([EPTGMK]i?|e[0-9]+)?$" .) -}}
          {{- fail (printf "<resources.%s.%s> has invalid format in value (%s). Valid formats are (Suffixed with EPTGMK eg. 1G) (Suffixed with EPTGMK + i eg. 1Gi) (Plain integer (in bytes) eg. 1024) (Exponent eg. 134e6)." $object $key .) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
