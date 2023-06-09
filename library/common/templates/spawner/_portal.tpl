{{/* Portal Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.portal" $ -}}
*/}}

{{- define "tc.v1.common.spawner.portal" -}}
    {{- range $name, $portal := .Values.portal -}}
      {{- if $portal.enabled -}}

        {{/* Create a copy of the portal */}}
        {{- $objectData := (mustDeepCopy $portal) -}}
        {{- $override := $objectData.override -}}
        {{- $targetSelector := $objectData.targetSelector -}}

        {{/* Create defaults */}}
        {{- $protocol := "http" -}}
        {{- $host := "$node_ip" -}}
        {{- $port := "443" -}}
        {{- $path := $objectData.path | default "/" -}}
        {{- $url := "" -}}


        {{/* Get service, default to primary */}}
        {{- $serviceData := dict "targetSelector" $targetSelector.service -}}
        {{- $selectedService := fromYaml ( include "tc.v1.common.lib.helpers.getSelectedServiceValues" (dict "rootCtx" $ "objectData" $serviceData)) }}

        {{/* read loadbalancer IPs for metallb */}}
        {{- if eq $selectedService.type "LoadBalancer" -}}
          {{- with $selectedService.loadBalancerIP -}}
            {{- $host = toString . -}}
          {{- end -}}

        {{/* set temporary storage for port name and port */}}
        {{- $targetPort := "" -}}
        {{- $selectedPort := "" -}}

        {{/* Fetch port values */}}
        {{- if $targetSelector.port -}}
        {{- $targetPort = $targetSelector.port -}}
        {{- else -}}
        {{- $targetPort = include "tc.v1.common.lib.util.service.ports.primary" (dict "svcName" $selectedService.shortName "svcValues" $selectedService ) -}}
        {{- end -}}


        {{- $selectedPort = get $selectedService.ports $targetPort -}}

        {{/* store port number */}}
        {{- $port = $selectedPort.port -}}
        {{- end -}}


        {{/* set temporary storage for ingress name and port */}}
        {{- $targetIngress := "" -}}
        {{- $selectedIngress := "" -}}

        {{/* Fetch ingress values */}}
        {{- if $targetSelector.ingress -}}
        {{- $targetIngress = $targetSelector.ingress -}}
        {{- else -}}
        {{- $targetIngress = ( include "tc.v1.common.lib.util.ingress.primary" $ ) -}}
        {{- end -}}

        {{- $selectedIngress = get $.Values.ingress $targetIngress -}}

        {{/* store host from ingress number */}}
        {{- if $selectedIngress -}}
        {{- if $selectedIngress.enabled -}}
        {{- with (index $selectedIngress.hosts 0) }}
           {{- $host = .host -}}
        {{- end }}

        {{/* Get the port for the ingress entrypoint */}}


        {{- $traefikNamespace := "tc-system" -}}
        {{- if $.Values.operator.traefik -}}
          {{- if $.Values.operator.traefik.namespace -}}
            {{- $traefikNamespace := $.Values.operator.traefik.namespace -}}
          {{- end -}}
        {{- end -}}
        {{- if $selectedIngress.ingressClassName }}
          {{- if $.Values.global.ixChartContext -}}
            {{- $traefikNamespace = (printf "ix-%s" $selectedIngress.ingressClassName) -}}
          {{- else -}}
            {{- $traefikNamespace = $selectedIngress.ingressClassName -}}
          {{- end -}}
        {{- end -}}

        {{- $traefikportalhook := lookup "v1" "ConfigMap" $traefikNamespace "portalhook" }}

        {{- $entrypoint := "websecure" }}
        {{- $protocol = "https" -}}
        {{- if $selectedIngress.entrypoint }}
          {{- $entrypoint = $selectedIngress.entrypoint }}
        {{- end }}

        {{- if $traefikportalhook }}
          {{- if ( index $traefikportalhook.data $entrypoint ) }}
            {{- $port = ( index $traefikportalhook.data $entrypoint ) }}
          {{- end }}
        {{- end }}

        {{- end }}
        {{- end }}


        {{- $port = ( toString $port ) -}}

        {{/* Apply overrides */}}
        {{- if $override.protocol -}}
          {{- $protocol = $override.protocol -}}
        {{- end -}}

        {{- if $override.host -}}
          {{- $host = $override.host -}}
        {{- end -}}

        {{- if $override.port -}}
          {{- $port = $override.port -}}
        {{- end -}}

        {{/* sanitise */}}
        {{- if eq $port "443" -}}
          {{- $protocol = "https" -}}
        {{- end -}}

        {{- if eq $port "80" -}}
          {{- $protocol = "http" -}}
        {{- end -}}

        {{/* TODO: Reenable when iX fixes bugs crashing GUI on empty port */}}
        {{/*
        {{- if or ( and ( eq $protocol "https" )  ( eq $port "443" ) ) ( and ( eq $protocol "http" )  ( eq $port "80" ) ) -}}
          {{- $port = "" -}}
        {{- end -}}
        */}}

        {{- $port = toString $port -}}

        {{/* Construct URL*/}}
        {{- if $port -}}
        {{- $url = printf "%s://%s:%s%s" $protocol $host $port $path -}}
        {{- else -}}
        {{- $url = printf "%s://%s%s" $protocol $host $path -}}
        {{- end -}}

        {{/* create configmap entry*/}}
        {{- $portalData := dict "protocol" $protocol "host" $host "port" $port "path" $path "url" $url  -}}

        {{/* construct configmap */}}
        {{- $objectName := ( printf "tcportal-%s" $name ) -}}
        {{- $configMap := dict "enabled" true "name" $objectName "shortName" $objectName "data" $portalData -}}

        {{/* Perform validations */}}
        {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName) -}}
        {{- include "tc.v1.common.lib.configmap.validation" (dict "objectData" $configMap) -}}
        {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $configMap "caller" "ConfigMap") -}}

        {{- if $.Values.ixChartContext -}}
        {{/* Call class to create the object */}}
        {{- include "tc.v1.common.class.configmap" (dict "rootCtx" $ "objectData" $configMap) -}}

        {{/* iXportals */}}
        {{- $useNodeIP := false -}}
        {{- if eq $host "$node_ip" -}}
        {{- $useNodeIP = true -}}
        {{- end -}}

        {{- $iXPortalData := dict "portalName" $name "useNodeIP" $useNodeIP "protocol" $protocol "host" $host "port" $port "path" $path "url" $url  -}}
        {{- $iXPortals := append $.Values.iXPortals $iXPortalData -}}
        {{- $_ := set $.Values "iXPortals" $iXPortals -}}

      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
