{{- define "ix.v1.common.portal.path" -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $port := .port -}}
  {{- $root := .root -}}

  {{- $portalPath := "/" -}}

  {{/* If ingress is added at any point, here is the place to implement */}}

  {{/* Check if there are any overrides in .Values.portal */}}
  {{- range $name, $svc := $root.Values.portal -}}
    {{- if eq $svcName $name -}}
      {{- range $name, $port := $svc -}}
        {{- if eq $portName $name -}}
          {{- if (hasKey $port "path") -}}
            {{- $portalPath = (tpl (toString $port.path) $root) -}}
            {{- if or (eq $portalPath "<nil>") (not $portalPath) -}} {{/* toString on a nil key returns the string "<nil>" */}}
              {{- fail "You have defined empty <path> in <portal>. Define a path or remove the key." -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- $portalPath -}}
{{- end -}}
