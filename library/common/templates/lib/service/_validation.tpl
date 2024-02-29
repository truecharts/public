{{/* Service Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.validation" (dict "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The service object.
*/}}

{{- define "tc.v1.common.lib.service.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if and $objectData.targetSelector (not (kindIs "string" $objectData.targetSelector)) -}}
    {{- fail (printf "Service - Expected [targetSelector] to be [string], but got [%s]" (kindOf $objectData.targetSelector)) -}}
  {{- end -}}

  {{- $svcTypes := (list "ClusterIP" "LoadBalancer" "NodePort" "ExternalName" "ExternalIP") -}}
  {{- if and $objectData.type (not (mustHas $objectData.type $svcTypes)) -}}
    {{- fail (printf "Service - Expected [type] to be one of [%s] but got [%s]" (join ", " $svcTypes) $objectData.type) -}}
  {{- end -}}

  {{- $hasEnabledPort := false -}}
  {{- if ne $objectData.type "ExternalName" -}}
    {{- range $name, $port := $objectData.ports -}}
      {{- $enabled := "false" -}}

      {{- if not (kindIs "invalid" $port.enabled) -}}
        {{- $enabled = (include "tc.v1.common.lib.util.enabled" (dict
                  "rootCtx" $rootCtx "objectData" $port
                  "name" $name "caller" "Service Validation Util"
                  "key" "port")) -}}
      {{- end -}}

      {{- if eq $enabled "true" -}}
        {{- $hasEnabledPort = true -}}

        {{- if and $port.targetSelector (not (kindIs "string" $port.targetSelector)) -}}
          {{- fail (printf "Service - Expected [port.targetSelector] to be [string], but got [%s]" (kindOf $port.targetSelector)) -}}
        {{- end -}}

        {{- if not $port.port -}}
          {{- fail (printf "Service - Expected non-empty [port.port]") -}}
        {{- end -}}

        {{- $protocolTypes := (list "tcp" "udp" "http" "https") -}}
        {{- if $port.protocol -}}
          {{- if not (mustHas (tpl $port.protocol $rootCtx) $protocolTypes) -}}
            {{- fail (printf "Service - Expected [port.protocol] to be one of [%s] but got [%s]" (join ", " $protocolTypes) $port.protocol) -}}
          {{- end -}}
        {{- end -}}

      {{- end -}}
    {{- end -}}

    {{- if not $hasEnabledPort -}}
      {{- fail "Service - Expected enabled service to have at least one port" -}}
    {{- end -}}
  {{- end -}}

{{- end -}}

{{/* Service Primary Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.primaryValidation" $ -}}
*/}}

{{- define "tc.v1.common.lib.service.primaryValidation" -}}

  {{/* Initialize values */}}
  {{- $hasPrimary := false -}}
  {{- $hasEnabled := false -}}

  {{- range $name, $service := .Values.service -}}
    {{- $enabled := "false" -}}

    {{- if not (kindIs "invalid" $service.enabled) -}}
      {{- $enabled = (include "tc.v1.common.lib.util.enabled" (dict
                "rootCtx" $ "objectData" $service
                "name" $name "caller" "Service Validation Util"
                "key" "service")) -}}
    {{- end -}}

    {{- if eq $enabled "true" -}}
      {{- $hasEnabled = true -}}

      {{/* And service is primary */}}
      {{- if and (hasKey $service "primary") ($service.primary) -}}
        {{/* Fail if there is already a primary service */}}
        {{- if $hasPrimary -}}
          {{- fail "Service - Only one service can be primary" -}}
        {{- end -}}

        {{- $hasPrimary = true -}}

        {{- include "tc.v1.common.lib.servicePort.primaryValidation" (dict "objectData" $service.ports) -}}

      {{- end -}}

    {{- end -}}
  {{- end -}}

  {{/* Require at least one primary service, if any enabled */}}
  {{- if and $hasEnabled (not $hasPrimary) -}}
    {{- fail "Service - At least one enabled service must be primary" -}}
  {{- end -}}

{{- end -}}

{{/* Service Port Primary Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.primaryValidation" (dict "objectData" $objectData -}}
objectData:
  The ports of the service.
*/}}

{{- define "tc.v1.common.lib.servicePort.primaryValidation" -}}
  {{- $objectData := .objectData -}}

  {{/* Initialize values */}}
  {{- $hasPrimary := false -}}
  {{- $hasEnabled := false -}}

  {{- range $name, $port := $objectData -}}

    {{/* If service is enabled */}}
    {{- if $port.enabled -}}
      {{- $hasEnabled = true -}}

      {{/* And service is primary */}}
      {{- if and (hasKey $port "primary") ($port.primary) -}}

        {{/* Fail if there is already a primary port */}}
        {{- if $hasPrimary -}}
          {{- fail "Service - Only one port per service can be primary" -}}
        {{- end -}}

        {{- $hasPrimary = true -}}

      {{- end -}}

    {{- end -}}
  {{- end -}}

  {{/* Require at least one primary service, if any enabled */}}
  {{- if and $hasEnabled (not $hasPrimary) -}}
    {{- fail "Service - At least one enabled port in service must be primary" -}}
  {{- end -}}

{{- end -}}
