{{- define "tc.v1.common.lib.ingress.backend.data" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $svcData := .svcData -}}
  {{- $override := .override -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}

  {{- with $override -}}
    {{- $name := .name -}}
    {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
        "rootCtx" $rootCtx "objectData" . "name" .name
        "caller" "Ingress" "key" "overrideService"
    )) -}}

    {{- if eq $expandName "true" -}}
      {{- $name = (printf "%s-%s" $fullname .name) -}}
    {{- end -}}
    {{- $svcData = (dict "name" $name "port" .port) -}}
  {{- end -}}

  {{- $svcData | toYaml -}}
{{- end -}}
