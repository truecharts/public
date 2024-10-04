{{/* EndpointSlice - Ports */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.endpointslice.ports" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The object data of the service
*/}}

{{- define "tc.v1.common.lib.endpointslice.ports" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $tcpProtocols := (list "tcp" "http" "https") -}}
  {{- range $name, $portValues := $objectData.ports -}}
    {{- if $portValues.enabled -}}
      {{- $protocol := $rootCtx.Values.global.fallbackDefaults.serviceProtocol -}} {{/* Default to fallback protocol, if no protocol is defined */}}
      {{- $port := $portValues.targetPort | default $portValues.port -}}

      {{/* Expand targetPort */}}
      {{- if (kindIs "string" $port) -}}
        {{- $port = (tpl $port $rootCtx) -}}
      {{- end -}}
      {{- $port = int $port -}}

      {{- with $portValues.protocol -}}
        {{- $protocol = tpl . $rootCtx -}}

        {{- if mustHas $protocol $tcpProtocols -}}
          {{- $protocol = "tcp" -}}
        {{- end -}}
      {{- end }}
- name: {{ $name }}
  port: {{ $port }}
  protocol: {{ $protocol | upper }}
      {{- with $portValues.appProtocol }}
  appProtocol: {{ tpl . $rootCtx | lower }}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
