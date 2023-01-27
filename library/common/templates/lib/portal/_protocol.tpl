{{- define "ix.v1.common.portal.protocol" -}}
  {{- $portalName := .portalName -}}
  {{- $svcType := .svcType -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $ingressName := .ingressName -}}
  {{- $ingress := .ingress -}}
  {{- $port := .port -}}
  {{- $root := .root -}}
  {{- $portal := get $root.Values.portalGenerator $portalName -}}

  {{- $portalProtocol := "https" -}}

  {{- if $port -}}
    {{- if $port.protocol -}}
      {{- if (mustHas $port.protocol (list "HTTP" "HTTPS")) -}}
        {{ $portalProtocol = ($port.protocol | lower) }}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{/* Configure portal for Ingress support */}}
  {{- if $ingress -}}
      {{ $portalProtocol = "https" }}
  {{- end -}}

  {{/* Check if there are any overrides in .Values.portalGenerator */}}
  {{- if $portal.protocol -}}
    {{- $portalProtocol = ((tpl (toString $portal.protocol) $root) | lower) -}}
    {{- if not (has $portalProtocol (list "http" "https" "ftp")) -}}
      {{- fail (printf "Invalid protocol (%s). Only http/https/ftp protocols are allowed for <portal>" $portalProtocol) -}}
    {{- end -}}
  {{- end -}}

  {{- $portalProtocol -}}
{{- end -}}
