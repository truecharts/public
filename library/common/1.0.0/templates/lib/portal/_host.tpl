{{- define "ix.v1.common.portal.host" -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $port := .port -}}
  {{- $root := .root -}}

  {{- $portalHost := "$node_ip" -}}

  {{- $svc := (get $root.Values.service $svcName) -}}
  {{- if eq $svc.type "LoadBalancer" -}}
    {{- with $svc.loadBalancerIP -}}
      {{- $portalHost = toString . -}}
    {{- end -}}
  {{- end -}}

  {{/* If ingress is added at any point, here is the place to implement */}}

  {{/* Check if there are any overrides in .Values.portal */}}
  {{- range $name, $svc := $root.Values.portal -}}
    {{- if eq $svcName $name -}}
      {{- range $name, $port := $svc -}}
        {{- if eq $portName $name -}}
          {{- if (hasKey $port "host") -}}
            {{- $portalHost = (tpl (toString $port.host) $root) -}}
            {{- if or (eq $portalHost "<nil>") (not $portalHost) -}} {{/* toString on a nil key returns the string "<nil>" */}}
              {{- fail "You have defined empty <host> in <portal>. Define a path or remove the key." -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end }}
{{ $portalHost }}
{{- end -}}
