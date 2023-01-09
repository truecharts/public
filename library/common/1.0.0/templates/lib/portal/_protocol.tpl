{{- define "ix.v1.common.portal.protocol" -}}
  {{- $svcType := .svcType -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $port := .port -}}
  {{- $root := .root -}}

  {{- $portalProtocol := "http" -}}

  {{- if $port.protocol -}}
    {{- if (mustHas $port.protocol (list "HTTP" "HTTPS")) -}}
      {{ $portalProtocol = ($port.protocol | lower) }}
    {{- end -}}
  {{- end -}}

  {{/* If ingress is added at any point, here is the place to implement */}}

  {{/* Check if there are any overrides in .Values.portal */}}
  {{- $tmpSVCPortal := get $root.Values.portal $svcName -}}
  {{- if $tmpSVCPortal -}}
    {{- $tmpPortPortal := get $tmpSVCPortal $portName -}}
    {{- if $tmpPortPortal -}}
      {{- if (hasKey $tmpPortPortal "protocol") -}}
        {{- $portalProtocol = ((tpl (toString $tmpPortPortal.protocol) $root) | lower) -}}
        {{- if not (has $portalProtocol (list "http" "https")) -}}
          {{- fail (printf "Invalid protocol (%s). Only HTTP/HTTPS protocols are allowed for <portal>" $portalProtocol) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $portalProtocol -}}
{{- end -}}
