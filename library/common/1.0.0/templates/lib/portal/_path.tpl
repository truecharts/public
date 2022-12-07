{{- define "ix.v1.common.portal.path" -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $port := .port -}}
  {{- $root := .root -}}

  {{- $portalPath := "/" -}}

  {{/* If ingress is added at any point, here is the place to implement */}}

  {{/* Check if there are any overrides in .Values.portal */}}
  {{- range $name, $portalSvc := $root.Values.portal -}}
    {{- if eq $svcName $name -}}
      {{- range $name, $portalPort := $portalSvc -}}
        {{- if eq $portName $name -}}
          {{- with $portalPort.path -}}
            {{- $portalPath = (tpl . $root) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end }}
{{ $portalPath }}
{{- end -}}
