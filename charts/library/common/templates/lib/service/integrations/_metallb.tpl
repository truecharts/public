{{- define "tc.v1.common.lib.service.integration.metallb" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $_ := set $objectData "integrations" ($objectData.integrations | default dict) -}}
  {{- $metallb := $objectData.integrations.metallb -}}

  {{- if $metallb.enabled -}}
    {{- include "tc.v1.common.lib.service.integration.validate" (dict "objectData" $objectData "integration" $metallb) -}}

    {{ $sharedKey := (include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Service")) }}
    {{- if $metallb.sharedKey -}}
      {{- $sharedKey = $metallb.sharedKey -}}
    {{- end -}}

    {{/* If externalTrafficPolicy is not set or is not Local, add the shared key as annotation */}}
    {{- if ne $objectData.externalTrafficPolicy "Local" -}}
      {{- $_ := set $objectData.annotations "metallb.io/allow-shared-ip" $sharedKey -}}
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
      {{- $_ := set $objectData.annotations "metallb.io/loadBalancerIPs" (join "," $ips) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
