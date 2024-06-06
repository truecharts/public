{{/* Returns Node Selector */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.nodeSelector" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.nodeSelector" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $selectors := dict -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.nodeSelector -}}
    {{- $selectors = . -}}
  {{- end -}}

  {{/* Override with pods option */}}
  {{- with $objectData.podSpec.nodeSelector -}}
    {{- $selectors = . -}}
  {{- end -}}

  {{- if and (include "tc.v1.common.lib.util.stopAll" $rootCtx) (eq $objectData.type "DaemonSet") }}
"non-existing": "true"
  {{ else }}
    {{- range $k, $v := $selectors -}}
      {{- if not $v -}}
      {{- else }}
{{ $k }}: {{ tpl $v $rootCtx | quote }}
      {{- end -}}
    {{- end -}}
  {{ end }}
{{- end -}}
