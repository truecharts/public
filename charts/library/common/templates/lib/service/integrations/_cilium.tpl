{{- define "tc.v1.common.lib.service.integration.cilium" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $cilium := $objectData.integrations.cilium -}}

  {{- if $cilium.enabled -}}
    {{- include "tc.v1.common.lib.service.integration.validate" (dict "objectData" $objectData "integration" $cilium) -}}

    {{- if $cilium.sharedKey -}}
      {{/* If externalTrafficPolicy is not set or is not Local, add the shared key as annotation */}}
      {{- if ne $objectData.externalTrafficPolicy "Local" -}}
        {{- $_ := set $objectData.annotations "lbipam.cilium.io/sharing-key" $cilium.sharedKey -}}
      {{- end -}}

      {{- $ips := list -}}

      {{/* Handle loadBalancerIP (single) */}}
      {{- if $objectData.loadBalancerIP -}}
        {{- $ips = mustAppend $ips (tpl $objectData.loadBalancerIP $rootCtx) -}}
      {{- end -}}

      {{/* Handle loadBalancerIPs (multiple) */}}
      {{- range $ip := $objectData.loadBalancerIPs -}}
        {{- $ips = mustAppend $ips (tpl $ip $rootCtx) -}}
      {{- end -}}

      {{- if $ips -}}
        {{- $_ := set set $objectData.annotations "lbipam.cilium.io/ips" (join "," $ips) -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
