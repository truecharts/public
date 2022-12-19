{{/* A placeholder is added, just to avoid having an empty configmap */}}
{{- define "ix.v1.common.class.portal" -}}
  {{- $root := .root -}}

---
apiVersion: {{ include "ix.v1.common.capabilities.configMap.apiVersion" . }}
kind: ConfigMap
metadata:
  name: portal
  {{- $labels := (default dict (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (default dict (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
data:
  portal: placeholder
  {{- range $svcName, $svc := $root.Values.service }}
    {{- if $svc.enabled -}}
      {{- $svcValues := $svc -}}
      {{- range $portName, $port := $svc.ports }}
        {{- $portalProtocol := include "ix.v1.common.portal.protocol" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim }}
        {{- $portalHost := include "ix.v1.common.portal.host" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim }}
        {{- $portalPort := include "ix.v1.common.portal.port" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim }}
        {{- $portalPath := include "ix.v1.common.portal.path" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim }}
  {{ printf "protocol-%v-%v" $svcName $portName }}: {{ $portalProtocol | quote }}
  {{ printf "host-%v-%v" $svcName $portName }}: {{ $portalHost | quote }}
  {{ printf "path-%v-%v" $svcName $portName }}: {{ $portalPath | quote }}
  {{ printf "port-%v-%v" $svcName $portName }}: {{ $portalPort | quote }}
  {{ printf "url-%v-%v" $svcName $portName }}: {{ printf "%v://%v:%v%v" $portalProtocol $portalHost $portalPort $portalPath | quote }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
