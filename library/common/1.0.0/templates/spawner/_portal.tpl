{{- define "ix.v1.common.spawner.portal" -}}
  {{- $data := dict -}}
  {{- $root := . -}}

  {{- if .Values.portal -}}
    {{- if .Values.portal.enabled -}}
      {{- range $svcName, $svc := $root.Values.service -}}
        {{- if $svc.enabled -}}
          {{- $svcValues := $svc -}}
          {{- range $portName, $port := $svc.ports -}}
            {{- $portalProtocol := include "ix.v1.common.portal.protocol" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim -}}
            {{- $portalHost := include "ix.v1.common.portal.host" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim -}}
            {{- $portalPort := include "ix.v1.common.portal.port" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim -}}
            {{- $portalPath := include "ix.v1.common.portal.path" (dict "svcType" $svc.type "svcName" $svcName "portName" $portName "port" $port "root" $root) | trim -}}
            {{- $_ := set $data (printf "protocol-%v-%v" $svcName $portName) ($portalProtocol | quote) -}}
            {{- $_ := set $data (printf "host-%v-%v" $svcName $portName) ($portalHost | quote) -}}
            {{- $_ := set $data (printf "path-%v-%v" $svcName $portName) ($portalPath | quote) -}}
            {{- $_ := set $data (printf "port-%v-%v" $svcName $portName) ($portalPort | quote) -}}
            {{- $_ := set $data (printf "url-%v-%v" $svcName $portName) (printf "%v://%v:%v%v" $portalProtocol $portalHost $portalPort $portalPath | quote) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}

      {{- if $data -}}
        {{/* Create the ConfigMap */}}
        {{- include "ix.v1.common.class.configmap" (dict "root" $root "configName" "portal" "type" "portal" "data" $data) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
