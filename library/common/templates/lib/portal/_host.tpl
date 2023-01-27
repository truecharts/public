{{- define "ix.v1.common.portal.host" -}}
  {{- $portalName := .portalName -}}
  {{- $svcType := .svcType -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $ingressName := .ingressName -}}
  {{- $ingress := .ingress -}}
  {{- $port := .port -}}
  {{- $root := .root -}}
  {{- $portal := get $root.Values.portalGenerator $portalName -}}

  {{- $portalHost := "$node_ip" -}}

  {{- $svc := (get $root.Values.service $svcName) -}}
  {{- if eq $svc.type "LoadBalancer" -}}
    {{- with $svc.loadBalancerIP -}}
      {{- $portalHost = toString . -}}
    {{- end -}}
  {{- end -}}

  {{/* Configure portal for Ingress support */}}
  {{- if $ingress -}}
    {{- with (first $ingress.hosts) }}
      {{- if .hostTpl }}
        {{ $portalHost = ( tpl .hostTpl $ ) }}
      {{- else if .host }}
        {{ $portalHost = .host }}
      {{- else }}
        {{ $portalHost = "$node_ip" }}
      {{- end }}
    {{- end }}
  {{- end -}}

  {{/* Check if there are any overrides in .Values.portalGenerator */}}
  {{- if $portal.host -}}
    {{- if or (kindIs "invalid" $portal.host) (not $portal.host) -}}
      {{- fail "You have defined empty <host> in <portal>. Define a host or remove the key." -}}
    {{- end -}}
    {{- $portalHost = (tpl (toString $portal.host) $root) -}}
  {{- end -}}

  {{- $portalHost -}}
{{- end -}}
