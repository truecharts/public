{{- define "ix.v1.common.portal.protocol" -}}
  {{- $svcType := .svcType -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $port := .port -}}
  {{- $root := .root -}}

  {{- $portalProtocol := "http" -}}

  {{- if $port.protocol -}}
    {{- if (has $port.protocol (list "HTTP" "HTTPS")) -}}
      {{ $portalProtocol = ($port.protocol | lower) }}
    {{- end -}}
  {{- end -}}

  {{/* If ingress is added at any point, here is the place to implement */}}

  {{/* Check if there are any overrides in .Values.portal */}}
  {{- range $name, $svc := $root.Values.portal -}}
    {{- if eq $svcName $name -}}
      {{- range $name, $port := $svc -}}
        {{- if eq $portName $name -}}
          {{- with $port.protocol -}}
            {{- $portalProtocol = (tpl (toString .) $root) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end }}
{{ $portalProtocol }}
{{- end -}}
