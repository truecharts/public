{{/* Returns the timeouts for the probe */}}
{{- define "ix.v1.common.container.probes.timeouts" -}}
  {{- $probeSpec := .probeSpec -}}
  {{- $probeName := .probeName -}}
  {{/* ints are usually parsed as floats in helm */}}
  {{- if not (mustHas (kindOf $probeSpec.initialDelaySeconds) (list "float64" "int")) -}}
    {{- fail (printf "<initialDelaySeconds> cannot be empty in probe (%s)" $probeName) -}}
  {{- end -}}
  {{- if not (mustHas (kindOf $probeSpec.failureThreshold) (list "float64" "int")) -}}
    {{- fail (printf "<failureThreshold> cannot be empty in probe (%s)" $probeName) -}}
  {{- end -}}
  {{- if not (mustHas (kindOf $probeSpec.timeoutSeconds) (list "float64" "int")) -}}
    {{- fail (printf "<timeoutSeconds> cannot be empty in probe (%s)" $probeName) -}}
  {{- end -}}
  {{- if not (mustHas (kindOf $probeSpec.periodSeconds) (list "float64" "int")) -}}
    {{- fail (printf "<periodSeconds> cannot be empty in probe (%s)" $probeName) -}}
  {{- end }}
initialDelaySeconds: {{ $probeSpec.initialDelaySeconds }}
failureThreshold: {{ $probeSpec.failureThreshold }}
timeoutSeconds: {{ $probeSpec.timeoutSeconds }}
periodSeconds: {{ $probeSpec.periodSeconds }}
{{- end -}}
