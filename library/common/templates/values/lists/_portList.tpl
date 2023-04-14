{{- define "tc.v1.common.values.portList" -}}
  {{- $rootCtx := . -}}
  {{- $svcValues := .svcValues -}}

  {{- $hasPrimaryPort := false -}}
  {{- range $portName, $portValues := $svcValues.ports -}}
    {{- if $portValues.enabled -}}
      {{- if $portValues.primary -}}
        {{- $hasPrimaryPort = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- range $portIdx, $portValues := $svcValues.portsList -}}
    {{- $portName := (printf "port-list-%s" (toString $portIdx)) -}}

    {{- if eq $portIdx 0 -}}
      {{- if not $hasPrimaryPort -}}
        {{- $_ := set $portValues "primary" true -}}
      {{- end -}}
    {{- end -}}

    {{- with $portValues.name -}}
      {{- $portName = . -}}
    {{- end -}}

    {{- if not (hasKey $svcValues "ports") -}}
      {{- $_ := set $svcValues "ports" dict -}}
    {{- end -}}

    {{- $_ := set $svcValues.ports $portName $portValues -}}
  {{- end -}}

{{- end -}}
