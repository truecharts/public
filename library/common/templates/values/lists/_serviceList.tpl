{{- define "tc.v1.common.values.serviceList" -}}
  {{- $rootCtx := . -}}

  {{- $hasPrimary := false -}}
  {{- range $svcName, $svcValues := $rootCtx.Values.service -}}
    {{- if $svcValues.enabled -}}
      {{- if $svcValues.primary -}}
        {{- $hasPrimary = true -}}
      {{- end -}} {{/* Check if "service" has a portList. */}}
      {{- include "tc.v1.common.values.portList" (dict "rootCtx" $rootCtx "svcValues" $svcValues) -}}
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

    {{- include "tc.v1.common.values.portList" (dict "rootCtx" $rootCtx "svcValues" $svcValues) -}}

    {{- $_ := set $rootCtx.Values.service $svcName $svcValues -}}

  {{- end -}}
{{- end -}}
