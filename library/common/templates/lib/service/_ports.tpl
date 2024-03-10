{{/* Service - Ports */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.ports" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The object data of the service
*/}}

{{- define "tc.v1.common.lib.service.ports" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $tcpProtocols := (list "tcp" "http" "https") -}}
  {{- range $name, $portValues := $objectData.ports -}}
    {{- if $portValues.enabled -}}
      {{- $protocol := $rootCtx.Values.global.fallbackDefaults.serviceProtocol -}} {{/* Default to fallback protocol, if no protocol is defined */}}
      {{- $port := $portValues.port -}}
      {{- $targetPort := $portValues.targetPort -}}
      {{- $nodePort := $portValues.nodePort -}}

      {{/* Expand port */}}
      {{- if (kindIs "string" $port) -}}
        {{- $port = (tpl $port $rootCtx) -}}
      {{- end -}}
      {{- $port = int $port -}}

      {{/* Expand targetPort */}}
      {{- if (kindIs "string" $targetPort) -}}
        {{- $targetPort = tpl $targetPort $rootCtx -}}
      {{- end -}}
      {{- $targetPort = int $targetPort -}}

      {{/* Expand nodePort */}}
      {{- if (kindIs "string" $nodePort) -}}
        {{- $nodePort = tpl $nodePort $rootCtx -}}
      {{- end -}}
      {{- $nodePort = int $nodePort -}}

      {{- with $portValues.protocol -}}
        {{- $protocol = tpl . $rootCtx -}}

        {{- if mustHas $protocol $tcpProtocols -}}
          {{- $protocol = "tcp" -}}
        {{- end -}}
      {{- end }}
- name: {{ $name }}
  port: {{ $port }}
  protocol: {{ $protocol | upper }}
  targetPort: {{ $targetPort | default $port }} {{/* If no targetPort, default to port */}}
      {{- if (eq $objectData.type "NodePort") -}}
        {{- if not $nodePort -}}
          {{- fail "Service - Expected non-empty [nodePort] on NodePort service type" -}}
        {{- end -}}

        {{- $minNodePort := int $rootCtx.Values.global.minNodePort -}}
        {{- if (lt $nodePort $minNodePort) -}}
          {{- fail (printf "Service - Expected [nodePort] to be higher than [%v], but got [%v]" $minNodePort $nodePort) -}}
        {{- end }}
  nodePort: {{ $nodePort }}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
