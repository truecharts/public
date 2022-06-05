{{/* merge controllerLabelsList with controllerLabels */}}
{{- define "tc.common.lib.values.controller.label.list" -}}
  {{- $controllerLabelsDict := dict }}
  {{- range .Values.controller.labelsList }}
  {{- $_ := set $controllerLabelsDict .name .value }}
  {{- end }}
  {{- $controllerlab := merge .Values.controller.labels $controllerLabelsDict }}
  {{- $_ := set .Values "labels" (deepCopy $controllerlab) -}}
{{- end -}}
