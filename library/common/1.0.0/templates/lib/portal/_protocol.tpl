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
  {{- range $name, $svc := $root.Values.portal -}}
    {{- if eq $svcName $name -}}
      {{- range $name, $port := $svc -}}
        {{- if eq $portName $name -}}
          {{- if (hasKey $port "protocol") -}}
            {{- $portalProtocol = ((tpl (toString $port.protocol) $root) | lower) -}}
            {{- if not (has $portalProtocol (list "http" "https")) -}}
              {{- fail (printf "Invalid protocol (%s). Only HTTP/HTTPS protocols are allowed for <portal>" $portalProtocol) -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- $portalProtocol -}}
{{- end -}}
