{{/* vim: set filetype=mustache: */}}
{{/*
Return the proper image name
{{ include "tc.common.images.image" ( dict "imageRoot" .Values.path.to.the.image "global" $) }}
*/}}
{{- define "tc.common.images.image" -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $tag := .imageRoot.tag | toString -}}
{{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}

{{/*
Return the image name using the selector
{{ include "tc.common.images.selector" . }}
*/}}
{{- define "tc.common.images.selector" -}}
{{- $imageDict := get .Values "image" }}
{{- $selected := .Values.imageSelector }}
{{- if hasKey .Values $selected }}
{{- $imageDict = get .Values $selected }}
{{- end }}
{{- $repositoryName := $imageDict.repository -}}
{{- $tag :=$imageDict.tag | toString -}}
{{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names (deprecated: use tc.common.images.renderPullSecrets instead)
{{ include "tc.common.images.pullSecrets" ( dict "images" (list .Values.path.to.the.image1, .Values.path.to.the.image2) "global" .Values.global) }}
*/}}
{{- define "tc.common.images.pullSecrets" -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names evaluating values as templates
{{ include "tc.common.images.renderPullSecrets" ( dict "images" (list .Values.path.to.the.image1, .Values.path.to.the.image2) "context" $) }}
*/}}
{{- define "tc.common.images.renderPullSecrets" -}}
{{- end -}}
