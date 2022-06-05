{{/* merge controllerAnnotationsList with controllerAnnotations */}}
{{- define "tc.common.lib.values.controller.annotations.list" -}}
  {{- $controllerAnnotationsDict := dict }}
  {{- range .Values.controller.annotationsList }}
  {{- $_ := set $controllerAnnotationsDict .name .value }}
  {{- end }}
  {{- $controlleranno := merge .Values.controller.annotations $controllerAnnotationsDict }}
  {{- $_ := set .Values.controller "annotations" (deepCopy $controlleranno) -}}
{{- end -}}
