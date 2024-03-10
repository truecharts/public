{{- define "tc.v1.common.values.serviceList" -}}
  {{- $rootCtx := . -}}

  {{- $primaryServiceName := include "tc.v1.common.lib.util.service.primary" (dict "rootCtx" $rootCtx) -}}
  {{- range $svcName, $svcValues := $rootCtx.Values.service -}}
    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $rootCtx "objectData" $svcValues
                    "name" $svcName "caller" "Service"
                    "key" "service")) -}}

    {{- if eq $enabled "true" -}}
      {{- include "tc.v1.common.values.portList" (dict "rootCtx" $rootCtx "svcValues" $svcValues) -}}
    {{- end -}}
  {{- end -}}

  {{- range $svcIdx, $svcValues := $rootCtx.Values.serviceList -}}
    {{- $svcName := (printf "svc-list-%s" (toString $svcIdx)) -}}

    {{- if eq $svcIdx 0 -}}
      {{- if not $primaryServiceName -}}
        {{- $_ := set $svcValues "primary" true -}}
      {{- end -}}
    {{- end -}}

    {{- with $svcValues.name -}}
      {{- $svcName = . -}}
    {{- end -}}

    {{- if not (hasKey $rootCtx.Values "service") -}}
      {{- $_ := set $rootCtx.Values "service" dict -}}
    {{- end -}}

    {{- include "tc.v1.common.values.portList" (dict "rootCtx" $rootCtx "svcValues" $svcValues) -}}

    {{- $_ := set $rootCtx.Values.service $svcName $svcValues -}}

  {{- end -}}
{{- end -}}
