{{- define "tc.v1.common.lib.service.integration.cilium" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $_ := set $objectData "integrations" ($objectData.integrations | default dict) -}}
  {{- $cilium := $objectData.integrations.cilium -}}

  {{- if $cilium.enabled -}}
    {{- include "tc.v1.common.lib.service.integration.validate" (dict "objectData" $objectData "integration" $cilium) -}}

    {{- if and $cilium.sharedKey (ne $objectData.externalTrafficPolicy "Local") -}}
      {{/* If externalTrafficPolicy is not set or is not Local, add the shared key as annotation */}}
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
      {{- $_ := set $objectData.annotations "lbipam.cilium.io/ips" (join "," $ips) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
