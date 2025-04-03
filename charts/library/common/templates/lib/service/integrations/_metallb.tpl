{{- define "tc.v1.common.lib.service.integration.metallb" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $metallb := $objectData.integrations.metallb -}}

  {{- if $metallb.enabled -}}
    {{- include "tc.v1.common.lib.service.integration.metallb.validate" (dict "objectData" $objectData) -}}

    {{ $sharedKey := ( include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Service")) }}
    {{- if $metallb.sharedKey -}}
      {{- $sharedKey = $metallb.sharedKey -}}
    {{- end -}}
      {{/* If externalTrafficPolicy is not set or is not Local, add the shared key as annotation */}}
      {{- if ne $metallb.externalTrafficPolicy "Local" -}}
        {{- $_ := set $objectData.annotations "metallb.io/allow-shared-ip" $sharedKey -}}
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
        {{- $_ := set set $objectData.annotations "metallb.io/loadBalancerIPs" (join "," $ips) -}}
      {{- end -}}

  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.service.integration.metallb.validate" -}}
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

    {{- if and $metallb.sharedKey ( eq $objectData.externalTrafficPolicy "Local" ) -}}
      {{- fail (printf "Service - [sharedKey], cannot both be used together with [externalTrafficPolicy] set to [Local]" ) -}}
    {{- end -}}

      {{- if and $objectData.loadBalancerIP $objectData.loadBalancerIPs -}}
        {{- fail "Service - Expected one of [loadBalancerIP, loadBalancerIPs] to be defined but got both" -}}
      {{- end -}}

{{- end -}}
