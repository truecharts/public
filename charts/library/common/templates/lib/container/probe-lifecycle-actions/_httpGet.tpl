{{/* Returns httpGet action */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.actions.httpGet" (dict "rootCtx" $ "objectData" $objectData "caller" $caller) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.actions.httpGet" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $caller := .caller -}}

  {{- if not $objectData.port -}}
    {{- fail (printf "Container - Expected non-empty [%s] [port] on [http] type" $caller) -}}
  {{- end -}}

  {{- $port := $objectData.port -}}
  {{- $path := "/" -}}
  {{- $scheme := "http" -}}

  {{- if kindIs "string" $port -}}
    {{- $port = tpl $port $rootCtx -}}
  {{- end -}}

  {{- with $objectData.path -}}
    {{- $path = tpl . $rootCtx -}}
  {{- end -}}

  {{- if not (hasPrefix "/" $path) -}}
    {{- fail (printf "Container - Expected [%s] [path] to start with a forward slash [/] on [http] type" $caller) -}}
  {{- end -}}

  {{- with $objectData.type -}}
    {{- $scheme = tpl . $rootCtx -}}
  {{- end }}
httpGet:
  {{- with $objectData.host }}
  host: {{ tpl . $rootCtx }}
  {{- end }}
  port: {{ $port }}
  path: {{ $path }}
  scheme: {{ $scheme | upper }}
  {{- with $objectData.httpHeaders }}
  httpHeaders:
    {{- range $name, $value := . }}
      {{- if not $value -}}
        {{- fail "Container - Expected non-empty [value] on [httpHeaders]" -}}
      {{- end }}
    - name: {{ $name }}
      value: {{ tpl (toString $value) $rootCtx  | quote }}
    {{- end -}}
  {{- end -}}

{{- end -}}
