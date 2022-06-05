{{/* merge podLabelsList with podLabels */}}
{{- define "tc.common.lib.values.pod.label.list" -}}
  {{- $podLabelsDict := dict }}
  {{- range .Values.controller.labelsList }}
  {{- $_ := set $podLabelsDict .name .value }}
  {{- end }}
  {{- $podlab := merge .Values.controller.labels $podLabelsDict }}
  {{- $_ := set .Values.controller "labels" (deepCopy $podlab) -}}
{{- end -}}
