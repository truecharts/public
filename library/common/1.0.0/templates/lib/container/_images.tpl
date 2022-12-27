{{/* Return the proper image name */}}
{{- define "ix.v1.common.images.image" -}}
  {{- $repo := (required "Image <repository> is required" .imageRoot.repository) -}}
  {{- $tag := ((required "Image <tag> is required" .imageRoot.tag) | toString) -}}
  {{- printf "%s:%s" $repo $tag -}}
{{- end -}}

{{- define "ix.v1.common.images.selector" -}}
  {{- $root := .root -}}
  {{- $selectedImage := .selectedImage -}}

  {{- if not $selectedImage -}}
    {{- $selectedImage = "image" -}}
  {{- end -}}

  {{- $image := "" -}}

  {{- if hasKey $root.Values $selectedImage -}}
    {{- $image = get $root.Values $selectedImage -}}
  {{- else if $selectedImage -}} {{/* If selectedImage does not exist in Values */}}
    {{- fail (printf "Selected image (%s) does not exist in values" $selectedImage) -}}
  {{- end -}}
  {{- include "ix.v1.common.images.image" (dict "imageRoot" $image) -}}
{{- end -}}

{{- define "ix.v1.common.images.pullPolicy" -}}
  {{- $root := .root -}}
  {{- $selectedImage := .selectedImage -}}

  {{- if not $selectedImage -}}
    {{- $selectedImage = "image" -}}
  {{- end -}}

  {{- $pullPolicy := "IfNotPresent" -}}
  {{- $image := "" -}}

  {{- if hasKey $root.Values $selectedImage -}}
    {{- $image = get $root.Values $selectedImage -}}
  {{- else if $selectedImage -}} {{/* If selectedImage does not exist in Values */}}
    {{- fail (printf "Selected image (%s) does not exist in values" $selectedImage) -}}
  {{- end -}}

  {{- with $image -}}
    {{- with .pullPolicy -}}
      {{- if not (mustHas . (list "IfNotPresent" "Always" "Never")) -}}
        {{- fail (printf "Invalid <pullPolicy> option (%s). Valid options are IfNotPresent, Always, Never" .) -}}
      {{- end -}}
      {{- $pullPolicy = . -}}
    {{- end -}}
  {{- end -}}
  {{- print $pullPolicy -}}
{{- end -}}
