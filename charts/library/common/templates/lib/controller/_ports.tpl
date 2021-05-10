{{/*
Ports included by the controller.
*/}}
{{- define "common.controller.ports" -}}
{{- $ports := list -}}
    {{/* append the ports for each service */}}
    {{- if $.Values.services -}}
      {{- range $name, $_ := $.Values.services }}
        {{- if .enabled -}}
          {{- if kindIs "string" $name -}}
            {{- $_ := set .port "name" (default .port.name | default $name) -}}
            {{- else -}}
            {{- $_ := set .port "name" (required "Missing port.name" .port.name) -}}
          {{- end -}}
          {{- $ports = mustAppend $ports .port -}}
          {{- range $_ := .additionalPorts -}}
            {{/* append the additonalPorts for each additional service */}}
            {{- $ports = mustAppend $ports . -}}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

{{/* export/render the list of ports */}}
{{- if $ports -}}
ports:
{{- range $_ := $ports }}
{{- $protocol := "" -}}
{{- if or ( eq .protocol "HTTP" ) ( eq .protocol "HTTPS" ) }}
  {{- $protocol = "TCP" -}}
{{- else }}
  {{- $protocol = .protocol | default "TCP" -}}
{{- end }}
- name: {{ required "The port's 'name' is not defined" .name }}
  {{- if and .targetPort (kindIs "string" .targetPort) }}
  {{- fail (printf "Our charts do not support named ports for targetPort. (port name %s, targetPort %s)" .name .targetPort) }}
  {{- end }}
  containerPort: {{ .targetPort | default .port }}
  protocol: {{ $protocol | default "TCP" }}
{{- end -}}
{{- end -}}
{{- end -}}
