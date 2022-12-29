{{/* Returns the resources for the container */}}
{{- define "ix.v1.common.container.resources" -}}
  {{- $resources := .resources -}}
  {{- $gpu := .gpu -}}
  {{- $root := .root -}}

  {{/* Get defaults from global */}}
  {{- $defautlResources := $root.Values.global.defaults.resources -}}
  {{- $limitsCPU := $defautlResources.limits.cpu -}}
  {{- $limitsMemory := $defautlResources.limits.memory -}}
  {{- $requestsCPU := $defautlResources.requests.cpu -}}
  {{- $requestsMemory := $defautlResources.requests.memory -}}
  {{/* TODO: Inherit */}}
  {{/* Modify based on user/dev input */}}
  {{- with $resources -}}
    {{- with $resources.requests -}}
      {{- if hasKey . "cpu" -}}
        {{- if ne $requestsCPU .cpu -}}
          {{- $requestsCPU = .cpu -}}
        {{- else if not .cpu -}} {{/* If key exists but it's empty, means user/dev explicitly said "no limit" */}}
          {{- $requestsCPU = "" -}}
        {{- end -}}
      {{- end -}}
      {{- if hasKey . "memory" -}}
        {{- if ne $requestsMemory .memory -}}
          {{- $requestsMemory = .memory -}}
        {{- else if not .memory -}} {{/* If key exists but it's empty, means user/dev explicitly said "no limit" */}}
          {{- $requestsMemory = "" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- with $resources.limits -}}
      {{- if hasKey . "cpu" -}}
        {{- if ne $limitsCPU .cpu -}}
          {{- $limitsCPU = .cpu -}}
        {{- else if not .cpu -}} {{/* If key exists but it's empty, means user/dev explicitly said "no limit" */}}
          {{- $limitsCPU = "" -}}
        {{- end -}}
      {{- end -}}
      {{- if hasKey . "memory" -}}
        {{- if ne $limitsMemory .memory -}}
          {{- $limitsMemory = .memory -}}
        {{- else if not .memory -}} {{/* If key exists but it's empty, means user/dev explicitly said "no limit" */}}
          {{- $limitsMemory = "" -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if or $resources $defautlResources $gpu -}}
    {{- if or $requestsCPU $requestsMemory  -}}
      {{- with (include "ix.v1.common.container.resources.cpuAndMemory" (dict "cpu" $requestsCPU "memory" $requestsMemory)) }}
requests:
        {{- . | indent 2 -}}
      {{- end -}}
    {{- end -}}
    {{- if or $limitsCPU $limitsMemory $gpu }}
limits:
      {{- include "ix.v1.common.container.resources.cpuAndMemory" (dict "cpu" $limitsCPU "memory" $limitsMemory) | indent 2 -}}
      {{- include "ix.v1.common.container.resources.gpu" (dict "gpu" $gpu) | indent 2 -}}
    {{- end -}}
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
