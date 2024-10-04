{{/* Returns Image Pull Secret List */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.imagePullSecret" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.imagePullSecret" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $imgPullSecrets := list -}}

  {{- range $name, $imgPull := $rootCtx.Values.imagePullSecret -}}
    {{- $pullName := (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) $name) -}}

    {{- if $imgPull.enabled -}}
      {{/* If targetSelectAll is true */}}
      {{- if $imgPull.targetSelectAll -}}
        {{- $imgPullSecrets = mustAppend $imgPullSecrets $pullName -}}

      {{/* Else if targetSelector is a list */}}
      {{- else if (kindIs "slice" $imgPull.targetSelector) -}}
        {{- if (mustHas $objectData.shortName $imgPull.targetSelector) -}}
          {{- $imgPullSecrets = mustAppend $imgPullSecrets $pullName -}}
        {{- end -}}

      {{/* If not targetSelectAll or targetSelector, but is the primary pod */}}
      {{- else if $objectData.primary -}}
        {{- $imgPullSecrets = mustAppend $imgPullSecrets $pullName -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}

  {{- range $imgPullSecrets }}
- name: {{ . }}
  {{- end -}}
{{- end -}}
