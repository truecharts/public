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

{{- define "ix.v1.common.images.pullPolicy" -}}
  {{- $pullPolicy := "IfNotPresent" -}}
  {{- with .policy -}}
    {{- if not (mustHas . (list "IfNotPresent" "Always" "Never")) -}}
      {{- fail (printf "Invalid <pullPolicy> option (%s). Valid options are IfNotPresent, Always, Never" .) -}}
    {{- end -}}
    {{- $pullPolicy = . -}}
  {{- end -}}
  {{- print $pullPolicy -}}
{{- end -}}
