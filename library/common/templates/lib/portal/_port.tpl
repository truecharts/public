{{- define "ix.v1.common.portal.port" -}}
  {{- $svcType := .svcType -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $port := .port -}}
  {{- $root := .root -}}

  {{- $portalPort := 443 -}}

  {{- if $root.Values.hostNetwork -}}
    {{- $portalPort = $port.port -}}
  {{- else if (hasKey $port "hostPort") -}}
    {{- $portalPort = $port.hostPort -}}
  {{- else if eq $svcType "NodePort" -}}
    {{- $portalPort = $port.nodePort -}}
  {{- else if eq $svcType "LoadBalancer" -}}
    {{- $portalPort = $port.port -}}
  {{- end -}}

  {{/* If ingress is added at any point, here is the place to implement */}}

  {{/* Check if there are any overrides in .Values.portal */}}
  {{- $tmpSVCPortal := get $root.Values.portal $svcName -}}
  {{- if $tmpSVCPortal -}}
    {{- $tmpPortPortal := get $tmpSVCPortal $portName -}}
    {{- if $tmpPortPortal -}}
      {{- if (hasKey $tmpPortPortal "port") -}}
        {{- $portalPort = (tpl (toString $tmpPortPortal.port) $root) -}}
        {{- if or (lt (int $portalPort) 1) (gt (int $portalPort) 65535) (eq (int $portalPort) 0) -}}
          {{- fail (printf "Port (%s) in <portal> is out of range. Range is 1-65535" $portalPort) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $portalPort -}}
{{- end -}}
