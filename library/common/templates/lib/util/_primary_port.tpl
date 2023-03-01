{{/* A dict containing .values and .serviceName is passed when this function is called */}}
{{/* Return the primary port for a given Service object. */}}
{{- define "tc.v1.common.lib.util.service.ports.primary" -}}
  {{- $svcName := .svcName -}}
  {{- $svcValues := .svcValues -}}

  {{- $enabledPorts := dict -}}

  {{- range $name, $port := $svcValues.ports -}}
    {{- if $port.enabled -}}
      {{- $_ := set $enabledPorts $name $port -}}
    {{- end -}}
  {{- end -}}

  {{- if not $enabledPorts -}}
    {{- fail (printf "No ports are enabled for the service: (%s)" $svcName) -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $port := $enabledPorts -}}
    {{- if (hasKey $port "primary") -}}
      {{- if $port.primary -}}
        {{- if $result -}}
          {{- fail (printf "More than one ports are set as primary in the (%s) service. This is not supported." $svcName ) -}}
        {{- end -}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- if eq (len $enabledPorts) 1 -}}
      {{- $result = keys $enabledPorts | mustFirst -}}
    {{- else -}}
      {{- if $enabledPorts -}}
        {{- fail (printf "At least one port must be set as primary in service (%s)" $svcName) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
