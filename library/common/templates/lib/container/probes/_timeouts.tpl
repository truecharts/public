{{/* Returns the timeouts for the probe */}}
{{- define "ix.v1.common.container.probes.timeouts" -}}
  {{- $probeSpec := .probeSpec -}}
  {{- $probeName := .probeName -}}
  {{- $containerName := .containerName -}}
  {{- $root := .root -}}

  {{/* Init default probe from global defaults */}}
  {{- $defaultProbeSpec := (get $root.Values.global.defaults.probes $probeName).spec -}}
  {{/* Overwrite with any values defined by the user/dev */}}
  {{- $probeSpec = mustMergeOverwrite $defaultProbeSpec $probeSpec -}}

  {{/* Validate values */}}
  {{- if not (mustHas (kindOf $probeSpec.initialDelaySeconds) (list "float64" "int")) -}}
    {{- fail (printf "<initialDelaySeconds> cannot be empty in probe (%s) in (%s) container" $probeName $containerName) -}}
  {{- end -}}
  {{- if not (mustHas (kindOf $probeSpec.failureThreshold) (list "float64" "int")) -}}
    {{- fail (printf "<failureThreshold> cannot be empty in probe (%s) in (%s) container" $probeName $containerName) -}}
  {{- end -}}
  {{- if not (mustHas (kindOf $probeSpec.timeoutSeconds) (list "float64" "int")) -}}
    {{- fail (printf "<timeoutSeconds> cannot be empty in probe (%s) in (%s) container" $probeName $containerName) -}}
  {{- end -}}
  {{- if not (mustHas (kindOf $probeSpec.periodSeconds) (list "float64" "int")) -}}
    {{- fail (printf "<periodSeconds> cannot be empty in probe (%s) in (%s) container" $probeName $containerName) -}}
  {{- end }}
initialDelaySeconds: {{ $probeSpec.initialDelaySeconds }}
failureThreshold: {{ $probeSpec.failureThreshold }}
timeoutSeconds: {{ $probeSpec.timeoutSeconds }}
periodSeconds: {{ $probeSpec.periodSeconds }}
{{- end -}}
