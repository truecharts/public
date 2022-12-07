{{- define "ix.v1.common.portal.port" -}}
  {{- $svcType := .svcType -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $port := .port -}}
  {{- $root := .root -}}

  {{- $portalPort := 443 -}}

  {{- if $root.Values.hostNetwork -}}
    {{- $portalPort = (default $port.port $port.targetPort) -}}
  {{- else if eq $svcType "NodePort" -}}
    {{- $portalPort = $port.nodePort -}}
  {{- else if eq $svcType "LoadBalancer" -}}
    {{- $portalPort = $port.port -}}
  {{- end -}}

  {{/* If ingress is added at any point, here is the place to implement */}}

  {{/* Check if there are any overrides in .Values.portal */}}
  {{- range $name, $portalSvc := $root.Values.portal -}}
    {{- if eq $svcName $name -}}
      {{- range $name, $portalPort := $portalSvc -}}
        {{- if eq $portName $name -}}
          {{- with $portalPort.port -}}
            {{- $portalPort = (tpl . $root) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end }}
{{ $portalPort }}
{{- end -}}
