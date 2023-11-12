{{/* Returns Host Aliases */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.hostAliases" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.hostAliases" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $aliases := list -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.hostAliases -}}
    {{- $aliases = . -}}
  {{- end -}}

  {{/* Override with pod's option */}}
  {{- with $objectData.podSpec.hostAliases -}}
    {{- $aliases = . -}}
  {{- end -}}

  {{- range $aliases -}}
    {{- if not .ip -}}
      {{- fail (printf "Expected non-empty [ip] value on [hostAliases].") -}}
    {{- end -}}

    {{- if not .hostnames -}}
      {{- fail (printf "Expected non-empty [hostames] list on [hostAliases].") -}}
    {{- end }}
- ip: {{ tpl .ip $rootCtx }}
  hostnames:
    {{- range .hostnames }}
  - {{ tpl . $rootCtx }}
    {{- end -}}
  {{- end -}}
{{- end -}}
