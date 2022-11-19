{{/* Return the proper image name */}}
{{- define "ix.v1.common.images.image" -}}
  {{- $repo := (required "Image <repository> is required" .imageRoot.repository) -}}
  {{- $tag := ((required "Image <tag> is required" .imageRoot.tag) | toString) -}}
  {{- printf "%s:%s" $repo $tag -}}
{{- end -}}

{{- define "ix.v1.common.images.selector" -}}
  {{- $image := get .Values "image" -}}
  {{- $selected := .Values.imageSelector -}}
  {{- if hasKey .Values $selected -}}
    {{- $image = get .Values $selected -}}
  {{- end -}}
  {{- include "ix.v1.common.images.image" (dict "imageRoot" $image) -}}
{{- end -}}
