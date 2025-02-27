{{/*
Template to render code-server addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "tc.v1.common.addon.codeserver" -}}
  {{- $codeSrv := $.Values.addons.codeserver -}}

  {{- if $codeSrv.enabled -}}
    {{- $targetSelector := list "main" -}}
    {{- if $codeSrv.targetSelector -}}
      {{- $targetSelector = $codeSrv.targetSelector -}}
    {{- end -}}

    {{- if gt ($targetSelector|len) 1 -}}
      {{- fail "Codeserver Addon - Can only be attached to a single workload at a time" -}}
    {{- end -}}

    {{/* Append the code-server container to the workloads */}}
    {{- range $targetSelector -}}
      {{- $workload := get $.Values.workload . -}}
      {{- $_ := set $workload.podSpec.containers "codeserver" $codeSrv.container -}}
    {{- end -}}

    {{/* Add the code-server service */}}
    {{- if $codeSrv.service.enabled -}}
      {{/* Add the code-server service */}}
      {{- $hasPrimaryService := false -}}
      {{- $result := (include "tc.v1.common.lib.service.hasPrimary" $) | fromJson -}}
      {{- if and $result.hasEnabled $result.hasPrimary -}}
        {{- $hasPrimaryService = true -}}
      {{- end -}}

      {{- $svcValues := $codeSrv.service -}}
      {{- $_ := set $svcValues "targetSelector" ($targetSelector|first) -}}
      {{- if not $hasPrimaryService -}}
        {{- $_ := set $svcValues "primary" true -}}
      {{- end -}}

      {{- if not $.Values.service -}}
        {{- $_ := set $.Values "service" dict -}}
      {{- end -}}

      {{- $_ := set $.Values.service "codeserver" $svcValues -}}
    {{- end -}}

    {{/* Add the code-server ingress */}}
    {{- if $codeSrv.ingress.enabled -}}
      {{- $ingressValues := $codeSrv.ingress -}}
      {{- if not $ingressValues.targetSelector -}}
        {{/* Assumes that both service and port are named codeserver */}}
        {{- $_ := set $ingressValues "targetSelector" (dict "codeserver" "codeserver") -}}
      {{- end -}}

      {{- $hasPrimaryIngress := false -}}
      {{- $result := (include "tc.v1.common.lib.ingress.hasPrimary" $) | fromJson -}}
      {{- if and $result.hasEnabled $result.hasPrimary -}}
        {{- $hasPrimaryIngress = true -}}
      {{- end -}}

      {{- if not $hasPrimaryIngress -}}
        {{- $_ := set $ingressValues "primary" true -}}
      {{- end -}}

      {{- if not $.Values.ingress -}}
        {{- $_ := set $.Values "ingress" dict -}}
      {{- end -}}

      {{/* Let spawner handle the rest */}}
      {{- $_ := set $.Values.ingress "codeserver" $ingressValues -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
