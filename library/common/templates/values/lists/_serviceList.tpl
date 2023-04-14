{{- define "tc.v1.common.values.serviceList" -}}
  {{- $rootCtx := . -}}

  {{- $hasPrimary := false -}}
  {{- range $svcName, $svcValues := $rootCtx.Values.service -}}
    {{- if $svcValues.enabled -}}
      {{- if $svcValues.primary -}}
        {{- $hasPrimary = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- range $svcIdx, $svcValues := $rootCtx.Values.serviceList -}}
    {{- $svcName := (printf "svc-list-%s" (toString $svcIdx)) -}}

    {{- if eq $svcIdx 0 -}}
      {{- if not $hasPrimary -}}
        {{- $_ := set $svcValues "primary" true -}}
      {{- end -}}
    {{- end -}}

    {{- with $svcValues.name -}}
      {{- $svcName = . -}}
    {{- end -}}

    {{- if not (hasKey $rootCtx.Values "service") -}}
      {{- $_ := set $rootCtx.Values "service" dict -}}
    {{- end -}}

    {{- range $portIdx, $portValues := $svcValues.portsList -}}
      {{- $portName := (printf "port-list-%s" (toString $portIdx)) -}}

      {{- if eq $portIdx 0 -}}
        {{- $_ := set $portValues "primary" true -}}
      {{- end -}}

      {{- with $portValues.name -}}
        {{- $portName = . -}}
      {{- end -}}

      {{- if not (hasKey $svcValues "ports") -}}
        {{- $_ := set $svcValues "ports" dict -}}
      {{- end -}}

      {{- $_ := set $svcValues.ports $portName $portValues -}}
    {{- end -}}

    {{- $_ := set $rootCtx.Values.service $svcName $svcValues -}}

  {{- end -}}
{{- end -}}
