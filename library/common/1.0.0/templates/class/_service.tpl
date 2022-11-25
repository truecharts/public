{{/* Template for service object, can only be called by the spawner */}}
{{/* An "svc" object and "root" is passed from the spawner */}}
{{- define "ix.v1.common.class.service" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root -}}

  {{- $svcName := include "ix.v1.common.names.fullname" $root -}}

  {{- if and (hasKey $svcValues "nameOverride") $svcValues.nameOverride -}}
    {{- $svcName = (printf "%v-%v" $svcName $svcValues.nameOverride) -}}
  {{- end -}}

  {{- $svcType := $svcValues.type | default "ClusterIP" -}}
  {{- $primaryPort := get $svcValues.ports (include "ix.v1.common.lib.util.service.ports.primary" (dict "values" $svcValues)) }}

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
  {{- $annotations := (mustMerge ($svcValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml) ($additionalAnnotations)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
{{- if has $svcType (list "ClusterIP" "NodePort" "ExternalName" "LoadBalancer") }}
  type: {{ $svcType }} {{/* Specify type only for the above types */}}
{{- end -}}
{{- if eq $svcType "ClusterIP" }} {{/* ClusterIP */}}
  {{- with $svcValues.clusterIP }}
  clusterIP: {{ . }}
  {{- end }}
{{- else if eq $svcType "ExternalName" -}} {{/* ExternalName */}}
  externalName: {{ $svcValues.externalName }}
{{- else if eq $svcType "LoadBalancer" -}} {{/* LoadBalancer */}}
  {{- with $svcValues.loadBalancerIP }}
  loadBalancerIP: {{ . }}
  {{- end }}
  {{- with $svcValues.loadBalancerSourceRanges }}
  loadBalancerSourceRanges:
    {{- range . }}
    - {{ tpl . $root }}
    {{- end }}
  {{- end -}}
{{- end -}}
{{- with $svcValues.externalTrafficPolicy -}}
  {{- if not (has . (list "Cluster" "Local")) -}}
    {{- fail (printf "Invalid option (%s) for <externalTrafficPolicy>. Valid options are Cluster and Local" .) -}}
  {{- end }}
  externalTrafficPolicy: {{ . }}
{{- end -}}
{{- with $svcValues.sessionAffinity }}
  {{- if not (has . (list "ClientIP" "None")) -}}
    {{- fail (printf "Invalid option (%s). Valid options are ClientIP and None" .) -}}
  {{- end }}
  sessionAffinity: {{ . }}
  {{- if eq . "ClientIP" -}}
    {{- with $svcValues.sessionAffinityConfig -}}
      {{- with .ClientIP -}}
        {{- if hasKey . "timeoutSeconds" }}
          {{- $timeout := tpl (toString .timeoutSeconds) $root -}}
          {{- if or (lt (int $timeout) 0) (gt (int $timeout) 86400) -}}
            {{- fail (printf "Invalid value (%s) for <sessionAffinityConfig.ClientIP.timeoutSeconds>. Valid values must be with 0 and 86400" $timeout) -}}
          {{- end }}
    sessionAffinityConfig:
      ClientIP:
        timeoutSeconds: {{ $timeout }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- with $svcValues.externalIPs }}
  externalIPs:
  {{- range . }}
    - {{ tpl . $root }}
  {{- end }}
{{- end -}}
{{- with $svcValues.publishNotReadyAddresses }}
  publishNotReadyAddresses: {{ . }}
{{- end -}}
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
{{- if eq $svcType "ExternalIP" }}
---
apiVersion: {{ include "ix.v1.common.capabilities.endpoints.apiVersion" $root }}
kind: Endpoints
metadata:
  name: {{ $svcName }}
  {{- $labels := (mustMerge ($svcValues.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($svcValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
  {{- with $svcValues.externalIP }}
subsets:
  - addresses:
      - {{ tpl . $root }}
  {{- else -}}
    {{- fail "Service type is set to ExternalIP, but no externalIP is defined." -}}
  {{- end -}}
    ports:
    {{- range $name, $port := $svcValues.ports }}
      {{- if $port.enabled }}
      - port: {{ $port.port }}
        name: {{ $name }}
      {{- end }}
    {{- end }}
{{- end -}}
{{- end -}}
