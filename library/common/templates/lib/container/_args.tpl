{{/* Returns args list */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.args" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.args" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- range $key := (list "args" "extraArgs") -}}
    {{- with (get $objectData $key) -}}
      {{- if kindIs "string" . }}
- {{ tpl . $rootCtx | quote }}
      {{- else if kindIs "slice" . -}}
        {{- range $arg := . }}
- {{ tpl $arg $rootCtx | quote }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
