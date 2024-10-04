{{/* Returns grpc action */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.actions.tcpSocket" (dict "rootCtx" $ "objectData" $objectData "caller" $caller) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.actions.grpc" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $caller := .caller -}}

   {{- if not $objectData.port -}}
    {{- fail (printf "Container - Expected non-empty [%s] [port] on [grpc] type" $caller) -}}
  {{- end -}}

  {{- $port := $objectData.port -}}

  {{- if kindIs "string" $port -}}
    {{- $port = tpl $port $rootCtx -}}
  {{- end }}
grpc:
  port: {{ $port }}
{{- end -}}
