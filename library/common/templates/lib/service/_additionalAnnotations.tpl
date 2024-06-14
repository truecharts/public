{{/* Service - MetalLB Annotations */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.metalLBAnnotations" (dict "rootCtx" $rootCtx "objectData" $objectData "annotations" $annotations) -}}
rootCtx: The root context of the chart.
objectData: The object data of the service
annotations: The annotations variable reference, to append the MetalLB annotations
*/}}

{{- define "tc.v1.common.lib.service.metalLBAnnotations" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $annotations := .annotations -}}

  {{- $sharedKey := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}

  {{/* A custom shared key can be defined per service even between multiple charts */}}
  {{- with $objectData.sharedKey -}}
    {{- $sharedKey = tpl . $rootCtx -}}
  {{- end -}}

  {{- if (hasKey $rootCtx.Values.global "metallb") -}}
    {{- if $rootCtx.Values.global.metallb.addServiceAnnotations -}}
      {{/* If externalTrafficPolicy is not set or is not Local, add the shared key as annotation */}}
      {{- if ne $objectData.externalTrafficPolicy "Local" -}}
        {{- $_ := set $annotations "metallb.universe.tf/allow-shared-ip" $sharedKey -}}
      {{- end -}}

      {{- if and $objectData.loadBalancerIP $objectData.loadBalancerIPs -}}
        {{- fail "Service - Expected one of [loadBalancerIP, loadBalancerIPs] to be defined but got both" -}}
      {{- end -}}

      {{- $ips := list -}}

      {{/* Handle loadBalancerIP (single) */}}
      {{- if $objectData.loadBalancerIP -}}
        {{- if not (kindIs "string" $objectData.loadBalancerIP) -}}
          {{- fail (printf "Service - Expected [loadBalancerIP] to be a string, but got [%s]" (kindOf $objectData.loadBalancerIP)) -}}
        {{- end -}}

        {{- $ips = mustAppend $ips (tpl $objectData.loadBalancerIP $rootCtx) -}}
      {{- end -}}

      {{/* Handle loadBalancerIPs (multiple) */}}
      {{- if $objectData.loadBalancerIPs -}}
        {{- if not (kindIs "slice" $objectData.loadBalancerIPs) -}}
          {{- fail (printf "Service - Expected [loadBalancerIPs] to be a slice, but got [%s]" (kindOf $objectData.loadBalancerIPs)) -}}
        {{- end -}}

        {{- range $ip := $objectData.loadBalancerIPs -}}
          {{- $ips = mustAppend $ips (tpl $ip $rootCtx) -}}
        {{- end -}}
      {{- end -}}

      {{- if $ips -}}
        {{- $_ := set $annotations "metallb.universe.tf/loadBalancerIPs" (join "," $ips) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/* Service - Traefik Annotations */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.traefikAnnotations" (dict "rootCtx" $rootCtx "annotations" $annotations) -}}
rootCtx: The root context of the chart.
annotations: The annotations variable reference, to append the Traefik annotations
*/}}

{{- define "tc.v1.common.lib.service.traefikAnnotations" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $annotations := .annotations -}}

  {{- if (hasKey $rootCtx.Values.global "traefik") -}}
    {{- if $rootCtx.Values.global.traefik.addServiceAnnotations -}}
      {{- $_ := set $annotations "traefik.ingress.kubernetes.io/service.serversscheme" "https" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
