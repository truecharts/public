{{- define "tc.v1.common.values.portList" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $svcValues := .svcValues -}}

  {{- $tmpSvcValues := mustDeepCopy $svcValues -}}
  {{- if not $tmpSvcValues.ports -}}
    {{- $_ := set $tmpSvcValues "ports" dict -}}
  {{- end -}}
  {{- range $portIdx, $portValues := $svcValues.portsList -}}
    {{- $portName := (printf "port-list-%s" (toString $portIdx)) -}}
    {{- $_ := set $tmpSvcValues.ports $portName $portValues -}}
  {{- end -}}

  {{- $primaryPortName := include "tc.v1.common.lib.util.service.ports.primary" (dict "rootCtx" $rootCtx "svcValues" $tmpSvcValues) -}}

  {{- range $portIdx, $portValues := $svcValues.portsList -}}
    {{- $portName := (printf "port-list-%s" (toString $portIdx)) -}}

    {{- if eq $portIdx 0 -}}
      {{- if not $primaryPortName -}}
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
