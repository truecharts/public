{{/* Returns the selected service or fallback to primary */}}
{{- define "tc.v1.common.lib.ingress.targetSelector" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $selectedService := (dict "name" "" "port" 0) -}}
  {{- $svcData := dict -}}
  {{- $portData := dict -}}
  {{- $svcName := "" -}}
  {{- $portName := "" -}}

  {{- if $objectData.targetSelector -}}
    {{/* We have validation that only 1 key is allowed */}}
    {{- $svcName = ($objectData.targetSelector | keys | mustFirst) -}}
    {{- $portName = (get $objectData.targetSelector $svcName) -}}
    {{- $svcData = (get $rootCtx.Values.service $svcName) -}}

    {{- if not $svcData -}}
      {{- fail (printf "Ingress - Expected targeted service [%s] to exist" $svcName) -}}
    {{- end -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
          "rootCtx" $rootCtx "objectData" $svcData
          "name" $svcName "caller" "Ingress"
          "key" "ingress")) -}}

    {{- if ne $enabled "true" -}}
      {{- fail (printf "Ingress - Expected targeted service [%s] to be enabled" $svcName) -}}
    {{- end -}}

  {{- else -}}
    {{/* Find the primary service */}}
    {{- range $name, $service := $rootCtx.Values.service -}}

      {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
            "rootCtx" $rootCtx "objectData" $service
            "name" $name "caller" "Ingress"
            "key" "ingress")) -}}

      {{/* Check if its enabled */}}
      {{- if eq $enabled "true" -}}

        {{- if $service.primary -}}
          {{- $svcName = $name -}}
          {{- $svcData = $service -}}

          {{/* Find the primary port */}}
          {{- range $name, $port := $svcData.ports -}}
            {{- if $port.primary -}}
              {{- $portName = $name -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}

    {{- if not $svcData -}}
      {{- fail "Ingress - Expected [targetSelector] or a primary service to exist" -}}
    {{- end -}}

  {{- end -}}

  {{- $portData = (get $svcData.ports $portName) -}}
  {{- if not $portData -}}
    {{- fail (printf "Ingress - Expected targeted service [%s] to have port [%s]" $svcName $portName) -}}
  {{- end -}}

  {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
      "rootCtx" $rootCtx "objectData" $portData
      "name" $portName "caller" "Ingress"
      "key" "ingress")) -}}

  {{- if ne $enabled "true" -}}
    {{- fail (printf "Ingress - Expected targeted service port [%s] to be enabled" $portName) -}}
  {{- end -}}

  {{- $expandedSvcName := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- if not $svcData.primary -}}
    {{- $expandedSvcName = printf "%s-%s" $expandedSvcName $svcName -}}
  {{- end -}}

  {{- $protocol := default "http" -}}
  {{- if eq $portData.protocol "https" -}}
    {{- $protocol = "https" -}}
  {{- end -}}

  {{- $selectedService = (dict "name" $expandedSvcName "port" (tpl ($portData.port | toString) $rootCtx) "protocol" $protocol) -}}

  {{- $selectedService | toYaml -}}
{{- end -}}
