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
  {{- $primaryPort := get $svcValues.port (include "ix.v1.common.lib.util.service.ports.primary" (dict "values" $svcValues)) -}}

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
  {{- $annotations := (mustMerge ($svcValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
  {{- if and $root.addAnnotations.traefik (eq ($primaryPort.protocol | default "") "HTTPS") }}
    traefik.ingress.kubernetes.io/service.serversscheme: https
  {{- end -}}
  {{- if and $root.addAnnotations.metallb (eq $svcType "LoadBalancer") }}
    metallb.universe.tf/allow-shared-ip: {{ include "ix.v1.common.names.fullname" . }}
  {{- end -}}
spec:
{{- if eq $svcType "ClusterIP" }} {{/* ClusterIP */}}
  type: {{ $svcType }}
  {{- with $svcValues.clusterIP }}
  clusterIP: {{ . }}
  {{- end }}
{{- else if eq $svcType "NodePort" -}} {{/* NodePort */}}
  type: {{ $svcType }}
{{- else if eq $svcType "ExternalName" -}} {{/* ExternalName */}}
  type: {{ $svcType }}
  externalName: {{ $svcValues.externalName }}
{{- else if eq $svcType "LoadBalancer" -}} {{/* LoadBalancer */}}
  type: {{ $svcType }}
  {{- with $svcValues.loadBalancerIP }}
  loadBalancerIP: {{ . }}
  {{- end }}
  {{- with $svcValues.loadBalancerSourceRanges }}
  loadBalancerSourceRanges:
    {{- range . }}
    - {{ tpl . $root }}
    {{- end }}
  {{- end }}
  {{- if $svcValues.externalTrafficPolicy -}}
    {{- if not (has $svcValues.externalTrafficPolicy (list "Cluster" "Local")) -}}
      {{- fail (printf "Invalid option (%s) for <externalTrafficPolicy>. Valid options are Cluster and Local" $svcValues) -}}
    {{- end }}
  externalTrafficPolicy: {{ $svcValues.externalTrafficPolicy }}
  {{- end -}}
  {{- with $svcValues.sessionAffinity }}
  sessionAffinity: {{ . }}
  {{- end -}}
{{- end -}}
ports:
{{- range $name, $port := $svcValues.ports }}
  {{- if $port.enabled }}
  - port: {{ $port.port }}
    targetPort: {{ $port.targetPort | default $name }}
    {{- if $port.protocol -}}
      {{- if has $port.protocol (list "HTTP" "HTTPS" "TCP") }}
    protocol: TCP
      {{- else }}
    protocol: {{ $port.protocol }}
      {{- end }}
    {{- else }}
    protocol: TCP
    {{- end }}
    name: {{ $name }}
    {{- if (and $port.nodePort (eq $svcType "NodePort")) }}
    nodePort: {{ $port.nodePort }}
    {{- end }}
  {{- end -}}
{{- end -}}
{{- if not (has $svcType (list "ExternalName" "ExternalIP")) }}
selector:
  {{- with $svcValues.selector }}
  {{/*TODO: */}}
  {{- else }}
    {{- include "ix.v1.common.labels.selectorLabels" $root | nindent 4 }}
  {{- end }}
{{- end -}}
{{- end -}}
