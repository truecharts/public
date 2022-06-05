{{/* merge persistenceLabelsList with persistenceLabels */}}
{{- define "tc.common.lib.values.persistence.label.list" -}}
  {{- range $index, $item := .Values.persistence }}
  {{- if $item.enabled }}
  {{- $persistenceLabelsDict := dict }}
  {{- range $item.labelsList }}
  {{- $_ := set $persistenceLabelsDict .name .value }}
  {{- end }}
  {{- $tmp := $item.labels }}
  {{- $persistencelab := merge $tmp $persistenceLabelsDict }}
  {{- $_ := set $item "labels" (deepCopy $persistencelab) -}}
  {{- end }}
  {{- end }}
{{- end -}}
