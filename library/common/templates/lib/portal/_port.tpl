{{- define "ix.v1.common.portal.port" -}}
  {{- $portalName := .portalName -}}
  {{- $svcType := .svcType -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $ingressName := .ingressName -}}
  {{- $ingress := .ingress -}}
  {{- $port := .port -}}
  {{- $root := .root -}}
  {{- $portal := get $root.Values.portalGenerator $portalName -}}

  {{- $portalPort := 443 -}}


  {{/* TODO: port ingress port system from https://github.com/truecharts/library-charts/blob/0898c5dee7b0ff9bb11ab2b4c8c2870cce61a697/charts/common/templates/SCALE/_portal.tpl */}}

  {{- if $root.Values.hostNetwork -}}
    {{- $portalPort = $port.port -}}
  {{- else if (hasKey $port "hostPort") -}}
    {{- $portalPort = $port.hostPort -}}
  {{- else if eq $svcType "NodePort" -}}
    {{- $portalPort = $port.nodePort -}}
  {{- else if eq $svcType "LoadBalancer" -}}
    {{- $portalPort = $port.port -}}
  {{- end -}}


  {{/* Check if there are any overrides in .Values.portalGenerator */}}
  {{- if $portal.port -}}
    {{- $portalPort = (tpl (toString $portal.port) $root) -}}
    {{- if or (lt (int $portalPort) 1) (gt (int $portalPort) 65535) (eq (int $portalPort) 0) -}}
      {{- fail (printf "Port (%s) in <portal> is out of range. Range is 1-65535" $portalPort) -}}
    {{- end -}}
  {{- end -}}

  {{- $portalPort -}}
{{- end -}}
