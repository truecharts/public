{{- define "ix.v1.common.lib.values.serviceList" -}}
  {{- $root := . -}}

  {{/* Go over the service list */}}
  {{- range $svcIndex, $service := $root.Values.serviceList -}}

    {{/* Used to track if the service is complete with at least one port */}}
    {{- $complete := false -}}

    {{- if $service.enabled -}}
      {{/* Generate the name */}}
      {{- $svcName := (printf "svc-list-%s" (toString $svcIndex)) -}}

      {{- with $service.name -}}
        {{- $svcName = . -}}
      {{- end -}}

      {{- range $portIndex, $port := $service.portsList -}}
        {{- if $port.enabled -}}
          {{/* Generate the name */}}
          {{- $portName := (printf "port-list-%s-%s" (toString $svcIndex) (toString $portIndex)) -}}

          {{- with $port.name -}}
            {{- $portName = . -}}
          {{- end -}}

          {{- if not (hasKey $service "ports") -}}
            {{- $_ := set $service "ports" dict -}}
          {{- end -}}

          {{- $_ := set $service.ports $portName $port -}}
          {{- $complete = true -}}
        {{- end -}}
      {{- end -}}

      {{/* Make sure a service dict exists before trying to add items */}}
      {{- if not (hasKey $root.Values "service") -}}
        {{- $_ := set $root.Values "service" dict -}}
      {{- end -}}

      {{/* Add the device as a service dict,
      other templates will take care of the
      service and ports */}}
      {{- if $complete -}}
        {{- $_ := set $root.Values.service $svcName $service -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
