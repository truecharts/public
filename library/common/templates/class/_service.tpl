{{/* Template for service object, can only be called by the spawner */}}
{{/* An "svc" object and "root" is passed from the spawner */}}
{{- define "ix.v1.common.class.service" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root -}}
  {{- $defaultServiceType := $root.Values.global.defaults.serviceType -}}
  {{- $defaultPortProtocol := $root.Values.global.defaults.portProtocol -}}
  {{- $svcName := include "ix.v1.common.names.service" (dict "root" $root "svcValues" $svcValues) -}}

  {{- $svcType := $svcValues.type | default $defaultServiceType -}}
  {{- if $root.Values.hostNetwork -}}
    {{- $svcType = "ClusterIP" -}} {{/* When hostNetwork is enabled, force ClusterIP as service type */}}
  {{- end -}}

  {{/* When hostPort is used, this port can only be assiged to a ClusterIP Service */}}
  {{/* If at least one port in a service has hostPort this service will be forced to ClusterIP */}}
  {{- range $name, $port := $svcValues.ports -}}
    {{- if $port.enabled -}}
      {{- if $port.hostPort -}}
        {{- $svcType = "ClusterIP" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $primaryPort := get $svcValues.ports (include "ix.v1.common.lib.util.service.ports.primary" (dict "svcValues" $svcValues "svcName" $svcName)) }}
---
apiVersion: {{ include "ix.v1.common.capabilities.service.apiVersion" $root }}
kind: Service
metadata:
  name: {{ $svcName }}
  {{- $labels := (mustMerge ($svcValues.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $additionalAnnotations := dict -}}
  {{- if and $root.Values.addAnnotations.traefik (eq ($primaryPort.protocol | default "") "HTTPS") -}}
    {{- $_ := set $additionalAnnotations "traefik.ingress.kubernetes.io/service.serversscheme" "https" -}}
  {{- end -}}
  {{- if and $root.Values.addAnnotations.metallb (eq $svcType "LoadBalancer") -}}
    {{- $sharedLBKey := include "ix.v1.common.names.fullname" $root -}}
    {{- with $svcValues.metalLBSharedKey -}}
      {{- $sharedLBKey = tpl . $root -}}
    {{- end -}}
    {{- $_ := set $additionalAnnotations "metallb.universe.tf/allow-shared-ip" $sharedLBKey -}}
  {{- end -}}
  {{- $annotations := (mustMerge ($svcValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml) $additionalAnnotations) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  {{- if eq $svcType "ClusterIP" -}}
    {{- include "ix.v1.common.class.serivce.clusterIP.spec" (dict "svc" $svcValues "root" $root) | nindent 2 -}}
  {{- else if eq $svcType "LoadBalancer" -}}
    {{- include "ix.v1.common.class.serivce.loadBalancer.spec" (dict "svc" $svcValues "root" $root)| nindent 2 -}}
  {{- else if eq $svcType "NodePort" -}}
    {{- include "ix.v1.common.class.serivce.nodePort.spec" (dict "svc" $svcValues "root" $root) | nindent 2 -}}
  {{- else if eq $svcType "ExternalName" -}}
    {{- include "ix.v1.common.class.serivce.externalName.spec" (dict "svc" $svcValues "root" $root) | nindent 2 -}}
  {{- end -}}
  {{- include "ix.v1.common.class.serivce.sessionAffinity" (dict "svc" $svcValues "root" $root) | indent 2 -}}
  {{- include "ix.v1.common.class.serivce.externalIPs" (dict "svc" $svcValues "root" $root) | indent 2 -}}
  {{- include "ix.v1.common.class.serivce.publishNotReadyAddresses" (dict "publishNotReadyAddresses" $svcValues.publishNotReadyAddresses) | indent 2 -}}
  {{- include "ix.v1.common.class.serivce.ports" (dict "ports" $svcValues.ports "svcType" $svcType "defaultPortProtocol" $defaultPortProtocol "root" $root) | indent 2 -}}
  {{- if not (mustHas $svcType (list "ExternalName" "ExternalIP")) -}}
    {{- include "ix.v1.common.class.serivce.selector" (dict "svc" $svcValues "root" $root) | nindent 2 -}}
  {{- end -}}
  {{- if eq $svcType "ExternalIP" -}}
    {{- include "ix.v1.common.class.serivce.externalTrafficPolicy" (dict "svc" $svcValues "root" $root) | nindent 2 -}}
    {{- include "ix.v1.common.class.serivce.endpoints" (dict "svc" $svcValues "svcName" $svcName "root" $root) | nindent 0 -}}
  {{- end -}}
{{- end -}}
