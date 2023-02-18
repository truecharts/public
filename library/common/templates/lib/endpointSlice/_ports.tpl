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
      {{- $protocol := $rootCtx.Values.fallbackDefaults.serviceProtocol -}} {{/* Default to fallback protocol, if no protocol is defined */}}
      {{- $appProtocol := $rootCtx.Values.fallbackDefaults.serviceProtocol -}}
      {{- $targetPort := $portValues.targetPort -}}

      {{- if not $targetPort -}}
        {{- $targetPort = $portValues.port -}}
      {{- end -}}

      {{/* Expand targetPort */}}
      {{- if (kindIs "string" $targetPort) -}}
        {{- $targetPort = (tpl $targetPort $rootCtx) -}}
      {{- end -}}
      {{- $targetPort = int $targetPort -}}

      {{- with $portValues.protocol -}}
        {{- $protocol = tpl . $rootCtx -}}
        {{- $appProtocol = tpl . $rootCtx -}}

        {{- if mustHas $protocol $tcpProtocols -}}
          {{- $protocol = "tcp" -}}
        {{- end -}}
      {{- end }}
- name: {{ $name }}
  port: {{ $targetPort }}
  protocol: {{ $protocol | upper }}
  appProtocol: {{ $appProtocol | lower }}
    {{- end -}}
  {{- end -}}

{{- end -}}
