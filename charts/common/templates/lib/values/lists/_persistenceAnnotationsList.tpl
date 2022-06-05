{{/* merge persistenceAnnotationsList with persistenceAnnotations */}}
{{- define "tc.common.lib.values.persistence.annotations.list" -}}
  {{- range $index, $item := .Values.persistence }}
  {{- if $item.enabled }}
  {{- $persistenceAnnotationsDict := dict }}
  {{- range $item.annotationsList }}
  {{- $_ := set $persistenceAnnotationsDict .name .value }}
  {{- end }}
  {{- $tmp := $item.annotations }}
  {{- $persistenceanno := merge $tmp $persistenceAnnotationsDict }}
  {{- $_ := set $item "annotations" (deepCopy $persistenceanno) -}}
  {{- end }}
  {{- end }}
{{- end -}}
