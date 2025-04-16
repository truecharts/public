{{- define "tc.v1.common.lib.service.integration.validate" -}}
  {{- $objectData := .objectData -}}
  {{- $integration := .integration -}}

  {{- if and $integration.sharedKey (eq $objectData.externalTrafficPolicy "Local") -}}
    {{- fail (printf "Service - [sharedKey], cannot both be used together with [externalTrafficPolicy] set to [Local]" ) -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.service.loadbalancer.validate" -}}
  {{- $objectData := .objectData -}}

  {{- if and $objectData.loadBalancerIPs (not (kindIs "slice" $objectData.loadBalancerIPs)) -}}
    {{- fail (printf "Service - Expected [loadBalancerIPs] to be a slice, but got [%s]" (kindOf $objectData.loadBalancerIPs)) -}}
  {{- end -}}

  {{- if and $objectData.loadBalancerIP (not (kindIs "string" $objectData.loadBalancerIP)) -}}
    {{- fail (printf "Service - Expected [loadBalancerIP] to be a string, but got [%s]" (kindOf $objectData.loadBalancerIP)) -}}
  {{- end -}}

  {{- if and $objectData.loadBalancerIP $objectData.loadBalancerIPs -}}
    {{- fail "Service - Expected one of [loadBalancerIP, loadBalancerIPs] to be defined but got both" -}}
  {{- end -}}

{{- end -}}
