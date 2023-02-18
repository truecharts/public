{{/* Returns command list */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.command" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.command" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if kindIs "string" $objectData.command }}
- {{ tpl $objectData.command $rootCtx | quote }}
  {{- else if kindIs "slice" $objectData.command -}}
    {{- range $objectData.command }}
- {{ tpl . $rootCtx | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}
