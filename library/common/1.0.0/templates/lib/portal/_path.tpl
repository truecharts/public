{{- define "ix.v1.common.portal.path" -}}
  {{- $svcName := .svcName -}}
  {{- $portName := .portName -}}
  {{- $port := .port -}}
  {{- $root := .root -}}

  {{- $portalPath := "/" -}}

  {{/* If ingress is added at any point, here is the place to implement */}}

  {{/* Check if there are any overrides in .Values.portal */}}
  {{- $tmpSVCPortal := get $root.Values.portal $svcName -}}
  {{- if $tmpSVCPortal -}}
    {{- $tmpPortPortal := get $tmpSVCPortal $portName -}}
    {{- if $tmpPortPortal -}}
      {{- if (hasKey $tmpPortPortal "path") -}}
        {{- if or (kindIs "invalid" $tmpPortPortal.path) (not $tmpPortPortal.path) -}}
          {{- fail "You have defined empty <path> in <portal>. Define a path or remove the key." -}}
        {{- end -}}
        {{- $portalPath = (tpl (toString $tmpPortPortal.path) $root) -}}
        {{- if not (hasPrefix "/" $portalPath) -}}
          {{- fail (printf "Portal path (%s) must start with a forward slash -> / <-" $portalPath) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $portalPath -}}
{{- end -}}
