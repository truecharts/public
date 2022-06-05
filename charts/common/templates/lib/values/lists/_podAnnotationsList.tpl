{{/* merge podAnnotationsList with podAnnotations */}}
{{- define "tc.common.lib.values.pod.annotations.list" -}}
  {{- $podAnnotationsDict := dict }}
  {{- range .Values.podAnnotationsList }}
  {{- $_ := set $podAnnotationsDict .name .value }}
  {{- end }}
  {{- $podanno := merge .Values.podAnnotations $podAnnotationsDict }}
  {{- $_ := set .Values "podAnnotations" (deepCopy $podanno) -}}
{{- end -}}
