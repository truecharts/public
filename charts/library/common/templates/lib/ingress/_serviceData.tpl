{{- define "tc.v1.common.lib.ingress.backend.data" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $svcData := .svcData -}}
  {{- $override := .override -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}

  {{- with $override -}}
    {{- $name := .name -}}
    {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
        "rootCtx" $rootCtx "objectData" . "name" $name
        "caller" "Ingress" "key" "overrideService"
    )) -}}

    {{/* Init */}}
    {{- $expName := $name -}}

    {{/* Expand if needed */}}
    {{- if eq $expandName "true" -}}
      {{/* But first check if the svc is primary */}}
      {{- $svc := (get $rootCtx.Values.service $name) | default dict -}}

      {{- if $svc.primary -}} {{/* If primary, use fullname */}}
        {{- $expName = $fullname -}}
      {{- else -}} {{/* If not primary, use fullname + name */}}
        {{- $expName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

    {{- end -}}

    {{- $svcData = (dict "name" $expName "port" .port) -}}
  {{- end -}}

  {{- $svcData | toYaml -}}
{{- end -}}
