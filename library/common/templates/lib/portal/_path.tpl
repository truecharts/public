{{- define "ix.v1.common.portal.path" -}}
  {{- $portalName := .portalName -}}
  {{- $svcType := .svcType -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $ingressName := .ingressName -}}
  {{- $ingress := .ingress -}}
  {{- $port := .port -}}
  {{- $root := .root -}}
  {{- $portal := get $root.Values.portalGenerator $portalName -}}

  {{- $portalPath := "/" -}}

  {{/* Configure portal for Ingress support */}}
  {{- if $ingress -}}
    {{- with (first $ingress.hosts) }}
      {{- if .paths }}
        {{- $portalPath = (first .paths).path  }}
      {{- end }}
    {{- end }}
  {{- end -}}

  {{/* Check if there are any overrides in .Values.portalGenerator */}}
  {{- if $portal.path -}}
    {{- if or (kindIs "invalid" $portal.path) -}}
      {{- fail "You have defined empty <path> in <portal>. Define a path or remove the key." -}}
    {{- end -}}
    {{- $portalPath = (tpl (toString $portal.path) $root) -}}
    {{- if not (hasPrefix "/" $portalPath) -}}
      {{- fail (printf "Portal path (%s) must start with a forward slash -> / <-" $portalPath) -}}
    {{- end -}}
  {{- end -}}

  {{- $portalPath -}}
{{- end -}}
