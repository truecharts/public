{{- define "tc.v1.common.values.serviceList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $serviceValues := $rootCtx.Values.serviceList -}}
    {{- $name := (printf "persist-list-%s" (toString $idx)) -}}

    {{- with $serviceValues.name -}}
      {{- $name = . -}}
    {{- end -}}

    {{- if not (hasKey $rootCtx.Values "service") -}}
      {{- $_ := set $rootCtx.Values "service" dict -}}
    {{- end -}}

    {{- $_ := set $rootCtx.Values.service $name $serviceValues -}}

  {{- end -}}
{{- end -}}
