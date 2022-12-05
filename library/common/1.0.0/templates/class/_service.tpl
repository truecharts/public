{{/* Template for service object, can only be called by the spawner */}}
{{/* An "svc" object and "root" is passed from the spawner */}}
{{- define "ix.v1.common.class.service" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root -}}
  {{- $defaultServiceType := $root.Values.global.defaults.defaultServiceType -}}
  {{- $svcName := include "ix.v1.common.names.fullname" $root -}}

  {{- if and (hasKey $svcValues "nameOverride") $svcValues.nameOverride -}}
    {{- $svcName = (printf "%v-%v" $svcName $svcValues.nameOverride) -}}
  {{- end -}}

  {{- $svcType := $svcValues.type | default $defaultServiceType -}}
  {{- if $root.Values.hostNetwork -}}
    {{- $svcType = "ClusterIP" -}} {{/* When hostNetwork is enabled, force ClusterIP as service type */}}
  {{- end -}}
  {{- $primaryPort := get $svcValues.ports (include "ix.v1.common.lib.util.service.ports.primary" (dict "values" $svcValues "svcName" $svcName)) -}}
  {{/* Prepare a dict to pass into includes */}}
  {{- $tmpSVC := dict -}}
  {{- $_ := set $tmpSVC "name" $svcName }}
---
apiVersion: {{ include "ix.v1.common.capabilities.service.apiVersion" $root }}
kind: Service
metadata:
  name: {{ $svcName }}
  {{- $labels := (mustMerge ($svcValues.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $additionalAnnotations := dict -}}
  {{- if and $root.Values.addAnnotations.traefik (eq ($primaryPort.protocol | default "") "HTTPS") }}
    {{- $_ := set $additionalAnnotations "traefik.ingress.kubernetes.io/service.serversscheme" "https" -}}
  {{- end -}}
  {{- if and $root.Values.addAnnotations.metallb (eq $svcType "LoadBalancer") }}
    {{- $_ := set $additionalAnnotations "metallb.universe.tf/allow-shared-ip" (include "ix.v1.common.names.fullname" $root) }}
  {{- end -}}
  {{- $annotations := (mustMerge ($svcValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml) $additionalAnnotations) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
{{- if has $svcType (list "ClusterIP" "NodePort" "ExternalName" "LoadBalancer") }}
  type: {{ $svcType }} {{/* Specify type only for the above types */}}
{{- end -}}
{{- if has $svcType (list "ClusterIP" "NodePort" "LoadBalancer") -}} {{/* ClusterIP */}}
  {{- with $svcValues.clusterIP }}
  clusterIP: {{ . }}
  {{- end -}}
  {{- if eq $svcType "LoadBalancer" -}}
    {{- with $svcValues.loadBalancerIP }}
  loadBalancerIP: {{ . }}
    {{- end -}}
    {{- with $svcValues.loadBalancerSourceRanges }}
  loadBalancerSourceRanges:
      {{- range . }}
      - {{ tpl . $root }}
      {{- end }}
    {{- end -}}
  {{- end -}}
{{- else if eq $svcType "ExternalName" }} {{/* ExternalName */}}
  externalName: {{ required "<externalName> is required when service type is set to ExternalName" $svcValues.externalName }}
{{- end -}}
{{- if ne $svcType "ClusterIP" -}}
  {{- with $svcValues.externalTrafficPolicy -}}
    {{- if not (has . (list "Cluster" "Local")) -}}
      {{- fail (printf "Invalid option (%s) for <externalTrafficPolicy>. Valid options are Cluster and Local" .) -}}
    {{- end }}
  externalTrafficPolicy: {{ . }}
  {{- end -}}
{{- end -}}
{{- if $svcValues.sessionAffinity -}}
  {{- include "ix.v1.common.class.serivce.sessionAffinity" (dict "svc" $svcValues "root" $root) | nindent 2 -}}
{{- end -}}
{{- if $svcValues.externalIPs -}}
  {{- include "ix.v1.common.class.serivce.externalIPs" (dict "externalIPs" $svcValues.externalIPs "root" $root) | nindent 2 -}}
{{- end -}}
{{- include "ix.v1.common.class.serivce.publishNotReadyAddresses" (dict "publishNotReadyAddresses" $svcValues.publishNotReadyAddresses) | nindent 2 -}}
{{- if has $svcType (list "ClusterIP" "NodePort" "LoadBalancer") -}}
  {{- with $svcValues.ipFamilyPolicy }}
    {{- if not (has . (list "SingleStack" "PreferDualStack" "RequireDualStack")) -}}
      {{ fail (printf "Invalid option (%s) for <ipFamilyPolicy>. Valid options are SingleStack, PreferDualStack, RequireDualStack" .) -}}
    {{- end }}
  ipFamilyPolicy: {{ . }}
  {{- end -}}
  {{- with $svcValues.ipFamilies }}
  ipFamilies:
    {{- range . }}
      {{- $ipFam := tpl . $root -}}
      {{- if not (has $ipFam (list "IPv4" "IPv6")) -}}
        {{- fail (printf "Invalid option (%s) for <ipFamilies[]>. Valid options are IPv4 and IPv6" $ipFam) -}}
      {{- end }}
    - {{ $ipFam }}
    {{- end }}
  {{- end -}}
{{- end }}
  ports:
{{- range $name, $port := $svcValues.ports }}
  {{- if $port.enabled }}
    {{- $protocol := "TCP" -}} {{/* Default to TCP if no protocol is specified */}}
    {{- with $port.protocol }}
      {{- if has . (list "HTTP" "HTTPS" "TCP") -}}
        {{- $protocol = "TCP" -}}
      {{- else -}}
        {{- $protocol = . -}}
      {{- end -}}
    {{- end }}
    - port: {{ $port.port }}
      name: {{ $name }}
      protocol: {{ $protocol }}
      targetPort: {{ $port.targetPort | default $name }}
    {{- if and (eq $svcType "NodePort") $port.nodePort }}
      nodePort: {{ $port.nodePort }}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- if not (has $svcType (list "ExternalName" "ExternalIP")) }}
  selector:
  {{- with $svcValues.selector -}} {{/* If custom selector defined */}}
    {{- range $k, $v := . }}
    {{ $k }}: {{ tpl $v $root }}
    {{- end -}}
  {{- else }} {{/* else use the generated selectors */}}
    {{- include "ix.v1.common.labels.selectorLabels" $root | nindent 4 }}
  {{- end }}
{{- end -}}
  {{- if eq $svcType "ExternalIP" -}}
    {{- $_ := set $tmpSVC "values" $svcValues -}}
    {{- include "ix.v1.common.class.serivce.endpoints" (dict "svc" $tmpSVC "root" $root) }}
  {{- end -}}
{{- end -}}
