{{/* Returns the resources for the container */}}
{{- define "ix.v1.common.container.resources" -}}
  {{- $resources := .resources -}}
  {{- $gpu := .gpu -}}

  {{- if or $resources $gpu -}}
    {{- with $resources.requests -}}
      {{- with (include "ix.v1.common.container.resources.cpuAndMemory" (dict "cpu" .cpu "memory" .memory)) -}}
requests:
        {{- . | indent 2 -}}
      {{- end -}}
    {{- end -}}
    {{- if or $resources.limits $gpu -}}
      {{- if or $resources.limits.cpu $resources.limits.memory $gpu }}
limits:
        {{- include "ix.v1.common.container.resources.cpuAndMemory" (dict "cpu" $resources.limits.cpu "memory" $resources.limits.memory) | indent 2 -}}
        {{- include "ix.v1.common.container.resources.gpu" (dict "gpu" $gpu) | indent 2 -}}
      {{- end -}}
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
{{ $k }}: {{ $v | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}
