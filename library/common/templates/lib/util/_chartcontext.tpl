{{/* Returns the primary Workload object */}}
{{- define "tc.v1.common.lib.util.chartcontext" -}}
  {{/* Create defaults */}}
  {{- $protocol := "https" -}}
  {{- $host := "127.0.0.1" -}}
  {{- $port := "443" -}}
  {{- $url := "" -}}
  {{- $podCIDR := "172.16.0.0/16" -}}
  {{- $svcCIDR := "172.17.0.0/16" -}}

  {{/* set temporary storage for ingress name and port */}}
  {{- $targetIngress := "" -}}
  {{- $selectedIngress := "" -}}

  {{/* Get service, default to primary */}}
  {{- $selectedService := fromYaml (include "tc.v1.common.lib.helpers.getSelectedServiceValues" (dict "rootCtx" $ )) -}}

  {{/* read loadbalancer IPs for metallb */}}
  {{- if eq $selectedService.type "LoadBalancer" -}}
    {{- with $selectedService.loadBalancerIP -}}
      {{- $host = toString . -}}
    {{- end -}}

    {{/* set temporary storage for port name and port */}}
    {{- $targetPort := "" -}}
    {{- $selectedPort := "" -}}
    {{/* Fetch port values */}}
    {{- $targetPort = include "tc.v1.common.lib.util.service.ports.primary" (dict "svcName" $selectedService.shortName "svcValues" $selectedService) -}}
    {{- $selectedPort = get $selectedService.ports $targetPort -}}
    {{/* store port number */}}
    {{- $port = $selectedPort.port -}}
  {{- end -}}

  {{/* Fetch ingress values */}}
  {{- $targetIngress = include "tc.v1.common.lib.util.ingress.primary" $ -}}
  {{- $selectedIngress = get $.Values.ingress $targetIngress -}}

  {{/* store host from ingress number */}}
  {{- if $selectedIngress -}}
    {{- if $selectedIngress.enabled -}}
      {{- with (index $selectedIngress.hosts 0) -}}
         {{- $host = .host -}}
      {{- end -}}
      {{/* Get the port for the ingress entrypoint */}}

      {{- $namespace := "tc-system" -}}
      {{- if $.Values.operator.traefik -}}
        {{- if $.Values.operator.traefik.namespace -}}
          {{- $namespace = $.Values.operator.traefik.namespace -}}
        {{- end -}}
      {{- end -}}

      {{- if $selectedIngress.ingressClassName -}}
        {{- if $.Values.global.ixChartContext -}}
          {{- $namespace = (printf "ix-%s" $selectedIngress.ingressClassName) -}}
        {{- else -}}
          {{- $namespace = $selectedIngress.ingressClassName -}}
        {{- end -}}
        
      {{- end -}}

      {{- $traefikportalhook := lookup "v1" "ConfigMap" $namespace "portalhook" -}}
      {{- $entrypoint := "websecure" -}}
      {{- if $selectedIngress.entrypoint -}}
        {{- $entrypoint = $selectedIngress.entrypoint -}}
      {{- end -}}
      {{- if $traefikportalhook -}}
        {{- if (index $traefikportalhook.data $entrypoint) -}}
          {{- $port = (index $traefikportalhook.data $entrypoint) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $port = toString $port -}}

  {{/* sanitise */}}
  {{- if eq $port "443" -}}
    {{- $protocol = "https" -}}
  {{- end -}}

  {{- if eq $port "80" -}}
    {{- $protocol = "http" -}}
  {{- end -}}

  {{- if or (and (eq $protocol "https") (eq $port "443")) (and (eq $protocol "http") (eq $port "80")) -}}
    {{- $port = "" -}}
  {{- end -}}

  {{/* Construct URL*/}}
  {{- if $port -}}
    {{- $url = printf "%s://%s:%s" $protocol $host $port -}}
  {{- else -}}
    {{- $url = printf "%s://%s" $protocol $host -}}
  {{- end -}}

  {{/* TrueNAS SCALE specific code */}}
  {{- if $.Values.ixChartContext -}}
    {{- if $.Values.ixChartContext.kubernetes_config -}}
      {{- $podCIDR = $.Values.ixChartContext.kubernetes_config.cluster_cidr -}}
      {{- $svcCIDR = $.Values.ixChartContext.kubernetes_config.service_cidr -}}
    {{- end -}}
  {{- else -}}
    {{/* TODO: Find ways to implement CIDR detection */}}
  {{- end -}}

  {{- if $.Values.chartContext -}}
    {{- if $.Values.chartContext.APPURL -}}
      {{- $url = $.Values.chartContext.APPURL -}}
    {{- end -}}

    {{- if $.Values.chartContext.podCIDR -}}
      {{- $podCIDR = $.Values.chartContext.podCIDR -}}
    {{- end -}}

    {{- if $.Values.chartContext.svcCIDR -}}
      {{- $svcCIDR = $.Values.chartContext.svcCIDR -}}
    {{- end -}}
  {{- end -}}

  {{- $_ := set $.Values.chartContext "APPURL" $url -}}
  {{- $_ := set $.Values.chartContext "podCIDR" $podCIDR -}}
  {{- $_ := set $.Values.chartContext "svcCIDR" $svcCIDR -}}
{{- end -}}
