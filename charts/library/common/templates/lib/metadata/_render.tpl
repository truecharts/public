{{/* Renders a dict of labels */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) }}
{{ include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" $annotations) }}
*/}}

{{- define "tc.v1.common.lib.metadata.render" -}}
  {{- $labels := .labels -}}
  {{- $annotations := .annotations -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $seenLabels := list -}}
  {{- $seenAnnotations := list -}}

  {{- with $labels -}}
    {{- range $k, $v := . -}}
      {{- if and $k $v -}}
        {{- if not (mustHas $k $seenLabels) }}
{{ $k }}: {{ tpl $v $rootCtx | quote }}
         {{- $seenLabels = mustAppend $seenLabels $k -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- with $annotations -}}
    {{- range $k, $v := . -}}
      {{- if and $k $v -}}
        {{- if not (mustHas $k $seenAnnotations) }}
{{ $k }}: {{ tpl $v $rootCtx | quote }}
         {{- $seenAnnotations = mustAppend $seenAnnotations $k -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
