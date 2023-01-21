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
  {{- $tmpSVCPortal := get $root.Values.portal $svcName -}}
  {{- if $tmpSVCPortal -}}
    {{- $tmpPortPortal := get $tmpSVCPortal $portName -}}
    {{- if $tmpPortPortal -}}
      {{- if (hasKey $tmpPortPortal "host") -}}
        {{- if or (kindIs "invalid" $tmpPortPortal.host) (not $tmpPortPortal.host) -}}
          {{- fail "You have defined empty <host> in <portal>. Define a host or remove the key." -}}
        {{- end -}}
        {{- $portalHost = (tpl (toString $tmpPortPortal.host) $root) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $portalHost -}}
{{- end -}}
