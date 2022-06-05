{{/* merge ingressAnnotationsList with ingressAnnotations */}}
{{- define "tc.common.lib.values.ingress.annotations.list" -}}
 {{- range $index, $item := .Values.ingress }}
 {{- if $item.enabled }}
 {{- $ingressAnnotationsDict := dict }}
 {{- range $item.annotationsList }}
 {{- $_ := set $ingressAnnotationsDict .name .value }}
 {{- end }}
 {{- $tmp := $item.annotations }}
 {{- $ingressanno := merge $tmp $ingressAnnotationsDict }}
 {{- $_ := set $item "annotations" (deepCopy $ingressanno) -}}
 {{- end }}
 {{- end }}
{{- end -}}
