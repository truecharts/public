{{- define "tc.v1.common.values.ingressList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $ingressValues := $rootCtx.Values.ingressList -}}
      {{- $name := (printf "ingress-list-%s" (toString $idx)) -}}

      {{- with $ingressValues.name -}}
        {{- $name = . -}}
      {{- end -}}

      {{- if not (hasKey $rootCtx.Values "ingress") -}}
        {{- $_ := set $rootCtx.Values "ingress" dict -}}
      {{- end -}}

      {{- $_ := set $rootCtx.Values.ingress $name $ingressValues -}}
  {{- end -}}
{{- end -}}
