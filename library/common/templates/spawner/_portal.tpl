{{- define "ix.v1.common.spawner.portal" -}}
  {{- $data := dict -}}
  {{- $root := . -}}
  {{- $fullName := include "ix.v1.common.names.fullname" . -}}
  {{- $ingress := dict }}

  {{/* Get the name of the primary service, if any */}}
  {{- $primaryServiceName := (include "ix.v1.common.lib.util.service.primary" (dict "services" .Values.service "root" $root)) -}}
  {{- $primaryIngressName := (include "tc.v1.common.lib.util.ingress.primary" (dict "ingresses" .Values.ingress "root" $root)) -}}

  {{- range $portalName, $portal := .Values.portalGenerator -}}
    {{- if $portal.enabled -}}


      {{- $svcName := $portal.linkedService | default $primaryServiceName -}}
      {{- $svc := get $root.Values.service $svcName -}}
      {{- $portName := $portal.linkedPort | default (include "ix.v1.common.lib.util.service.ports.primary" (dict "svcValues" $svc "svcName" $svcName )) -}}
      {{- $port := get $svc.ports $portName -}}
      {{- $ingressName := $portal.linkedIngress | default $primaryIngressName -}}
      {{- if $ingressName }}
        {{- $ingress = get $root.Values.ingress $ingressName -}}
      {{- end -}}

      {{- $portalPath := $portal.path | default "/" -}}

      {{- $portalProtocol := include "ix.v1.common.portal.protocol" (dict "ingressName" $ingressName "ingress" $ingress "portalName" $portalName "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim -}}
      {{- $portalHost := include "ix.v1.common.portal.host" (dict "ingressName" $ingressName "ingress" $ingress "portalName" $portalName "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim -}}
      {{- $portalPort := include "ix.v1.common.portal.port" (dict "ingressName" $ingressName "ingress" $ingress "portalName" $portalName "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim -}}
      {{- $portalPath := include "ix.v1.common.portal.path" (dict "ingressName" $ingressName "ingress" $ingress "portalName" $portalName "root" $root) | trim -}}

      {{- $_ := set $data (printf "portname-%v" $portalName) ($portName) -}}
      {{- $_ := set $data (printf "svcname-%v" $portalName) ($svcName) -}}
      {{- $_ := set $data (printf "ingressname-%v" $portalName) ($ingressName) -}}
      {{- $_ := set $data (printf "protocol-%v" $portalName) ($portalProtocol) -}}
      {{- $_ := set $data (printf "host-%v" $portalName) ($portalHost) -}}
      {{- $_ := set $data (printf "path-%v" $portalName) ($portalPath) -}}
      {{- $_ := set $data (printf "port-%v" $portalName) ($portalPort) -}}
      {{- $_ := set $data (printf "url-%v" $portalName) (printf "%v://%v:%v%v" $portalProtocol $portalHost $portalPort $portalPath) -}}
      {{/* remove port when 80 or 443 */}}

    {{- end -}}
  {{- end -}}

  {{- if $data -}}
    {{/* Create the ConfigMap */}}
    {{- $data := toYaml $data -}}
    {{- include "ix.v1.common.class.configmap" (dict "root" $root "configName" "portal" "contentType" "yaml" "data" $data) -}}
  {{- end -}}


{{- end -}}
