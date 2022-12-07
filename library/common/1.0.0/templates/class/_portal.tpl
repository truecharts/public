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
  placeholder: for_non_empty_configmap
  {{- range $svcName, $svc := $root.Values.service }}
    {{- if $svc.enabled -}}
      {{- $svcValues := $svc -}}
      {{- range $portName, $port := $svc.ports }}
        {{- $portalProtocol := include "ix.v1.common.portal.protocol" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim }}
        {{- $portalHost := include "ix.v1.common.portal.host" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim }}
        {{- $portalPort := include "ix.v1.common.portal.port" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim }}
        {{- $portalPath := include "ix.v1.common.portal.path" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim }}
  {{ printf "protocol-%v-%v" $svcName $portName }}: {{ $portalProtocol }}
  {{ printf "host-%v-%v" $svcName $portName }}: {{ $portalHost }}
  {{ printf "path-%v-%v" $svcName $portName }}: {{ $portalPath }}
  {{ printf "port-%v-%v" $svcName $portName }}: {{ $portalPort }}
  {{ printf "url-%v-%v" $svcName $portName }}: {{ printf "%v://%v:%v%v" $portalProtocol $portalHost $portalPort $portalPath }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{/*
Current "bugs", you can't disable per app portal,
if port protocol is not HTTP or HTTPS,
it will still create an HTTP portal.
For this reason a placeholder is added,
so we don't result in an empty configmap
*/}}
