{{/* A dict containing .values and .serviceName is passed when this function is called */}}
{{/* Return the primary port for a given Service object. */}}
{{- define "ix.v1.common.lib.util.service.ports.primary" -}}
  {{- $enabledPorts := dict -}}
  {{- range $name, $port := .values.ports -}}
    {{- if $port.enabled -}}
      {{- $_ := set $enabledPorts $name . -}}
    {{- end -}}
  {{- end -}}

  {{- if not $enabledPorts -}}
    {{- fail (printf "No ports are enabled for the service (%s)" .serviceName) -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $port := $enabledPorts -}}
    {{- if $result -}}
      {{- fail "More than one ports are set as primary in the primary service. This is not supported." -}}
    {{- end -}}
    {{- if (hasKey $port "primary") -}}
      {{- if $port.primary -}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledPorts | first -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
