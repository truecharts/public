{{- define "ix.v1.common.class.serivce.ports" -}}
  {{- $defaultPortProtocol := .defaultPortProtocol -}}
  {{- $svcType := .svcType -}}
  {{- $root := .root -}}
  {{- $ports := .ports }}
ports:
  {{- range $name, $port := $ports -}}
    {{- if $port.enabled -}}
      {{- $protocol := $defaultPortProtocol -}} {{/* Default to TCP if no protocol is specified */}}
      {{- with $port.protocol -}}
        {{- if mustHas . (list "TCP" "HTTP" "HTTPS") -}}
          {{- $protocol = "TCP" -}}
        {{- else -}}
          {{- $protocol = . -}}
        {{- end -}}
      {{- end }}
  - port: {{ $port.port }}
    name: {{ $name }}
    protocol: {{ $protocol }}
    targetPort: {{ $port.targetPort | default $name }}
      {{- if and (eq $svcType "NodePort") $port.nodePort -}}
        {{- if lt $port.nodePort $root.Values.global.defaults.minimumNodePort -}}
          {{- fail (printf "Port number (%s) for (%s) is too low. The minimum port for Node Port is (%s)" ($port.nodePort | toString) $name ($root.Values.global.defaults.minimumNodePort | toString)) -}}
        {{- end }}
    nodePort: {{ $port.nodePort }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
