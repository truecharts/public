{{- define "tc.v1.common.lib.service.integration.cilium" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $cilium := $objectData.integrations.cilium -}}

  {{- if $cilium.enabled -}}
    {{- include "tc.v1.common.lib.service.integration.cilium.validate" (dict "objectData" $objectData) -}}

    {{- if $cilium.sharedKey -}}
      {{/* If externalTrafficPolicy is not set or is not Local, add the shared key as annotation */}}
      {{- if ne $objectData.externalTrafficPolicy "Local" -}}
        {{- $_ := set $objectData.annotations "lbipam.cilium.io/sharing-key" $cilium.sharedKey -}}
      {{- end -}}
      {{- end -}}

      {{- $ips := list -}}

      {{/* Handle loadBalancerIP (single) */}}
      {{- if $objectData.loadBalancerIP -}}
        {{- $ips = mustAppend $ips (tpl $objectData.loadBalancerIP $rootCtx) -}}
      {{- end -}}

      {{/* Handle loadBalancerIPs (multiple) */}}
      {{- if $objectData.loadBalancerIPs -}}
        {{- range $ip := $objectData.loadBalancerIPs -}}
          {{- $ips = mustAppend $ips (tpl $ip $rootCtx) -}}
        {{- end -}}
      {{- end -}}

      {{- if $ips -}}
        {{- $_ := set set $objectData.annotations "lbipam.cilium.io/ips" (join "," $ips) -}}
      {{- end -}}

  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.service.integration.cilium.validate" -}}
  {{- $objectData := .objectData -}}

      {{- if $objectData.loadBalancerIPs -}}
        {{- if not (kindIs "slice" $objectData.loadBalancerIPs) -}}
          {{- fail (printf "Service - Expected [loadBalancerIPs] to be a slice, but got [%s]" (kindOf $objectData.loadBalancerIPs)) -}}
        {{- end -}}
      {{- end -}}

      {{- if $objectData.loadBalancerIP -}}
        {{- if not (kindIs "string" $objectData.loadBalancerIP) -}}
          {{- fail (printf "Service - Expected [loadBalancerIP] to be a string, but got [%s]" (kindOf $objectData.loadBalancerIP)) -}}
        {{- end -}}
      {{- end -}}

    {{- if and $cilium.sharedKey ( eq $objectData.externalTrafficPolicy "Local" ) -}}
      {{- fail (printf "Service - [sharedKey], cannot both be used together with [externalTrafficPolicy] set to [Local]" ) -}}
    {{- end -}}

      {{- if and $objectData.loadBalancerIP $objectData.loadBalancerIPs -}}
        {{- fail "Service - Expected one of [loadBalancerIP, loadBalancerIPs] to be defined but got both" -}}
      {{- end -}}

{{- end -}}
