{{/*
If no targetPort is given, default to port.
This is for cases where port (that container listens)
can be dynamically configured via an env var.
*/}}
{{/* Ports included by the container. */}}
{{- define "ix.v1.common.container.ports" -}}
  {{- $defaultPortProtocol := .Values.global.defaults.portProtocol -}}
  {{- $ports := list -}}

  {{- range $svcName, $svc := .Values.service -}}
    {{- if $svc.enabled -}}
      {{- if not $svc.ports -}}
        {{- fail (printf "At least one port is required in an enabled service (%s)" $svcName) -}}
      {{- end -}}
      {{- range $name, $port := $svc.ports -}}
        {{- $_ := set $port "name" $name -}}
        {{- $ports = mustAppend $ports $port -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{/* Render the list of ports */}}
  {{- if $ports -}}
    {{- range $ports -}}
      {{- if .enabled -}}
        {{- if not .port -}}
          {{- fail (printf "Port is required on enabled services. Service (%s)" .name) -}}
        {{- end -}}
        {{- if and .targetPort (kindIs "string" .targetPort) -}}
          {{- fail (printf "This common library does not support named ports for targetPort. port name (%s), targetPort (%s)" .name .targetPort) -}}
        {{- end -}}
        {{- $protocol := $defaultPortProtocol -}}
        {{- with .protocol -}}
          {{- if mustHas . (list "HTTP" "HTTPS" "TCP") -}}
            {{- $protocol = "TCP" -}}
          {{- else if (eq . "UDP") -}}
            {{- $protocol = "UDP" -}}
          {{- else -}}
            {{- fail (printf "Not valid <protocol> (%s)" .) -}}
          {{- end -}}
        {{- end }}
- name: {{ tpl .name $ }}
  containerPort: {{ default .port .targetPort }}
  protocol: {{ $protocol }}
        {{- with .hostPort }}
  hostPort: {{ . }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/* This is called by init/install/upgrade/additional containers only */}}
{{- define "ix.v1.common.container.extraContainerPorts" -}}
  {{- $containerName := .containerName -}}
  {{- $ports := .ports -}}
  {{- $root := .root -}}

  {{- range $port := $ports -}}
    {{- if not $port.name -}}
      {{- fail (printf "<name> is required in all <ports> in (%s) container." $containerName) -}}
    {{- end -}}
    {{- if not $port.protocol -}}
      {{- $_ := set $port "protocol" "TCP" -}}
    {{- end -}}
    {{- if not (mustHas $port.protocol (list "TCP" "UDP")) -}}
      {{- fail (printf "Invalid <protocol> (%s) in port (%s) in (%s) container. Valid protocols are TCP and UDP." $port.protocol $port.name $containerName) -}}
    {{- end -}}
    {{- if not $port.containerPort -}}
      {{- fail (printf "<containerPort> is required in port (%s) in (%s) container." $port.name $containerName) -}}
    {{- end -}}
    {{- if not (mustHas (kindOf $port.containerPort) (list "int" "float64")) -}}
      {{- fail (printf "Invalid <containerPort> (%s) in port (%s) in (%s) container. Must be an int." $port.containerPort $port.name $containerName) -}}
    {{- end -}}
    {{- if $port.hostPort -}}
      {{- if not (mustHas (kindOf $port.hostPort) (list "int" "float64")) -}}
        {{- fail (printf "Invalid <hostPort> (%s) in port (%s) in (%s) container. Must be an int." $port.hostPort $port.name $containerName) -}}
      {{- end -}}
    {{- end }}
- name: {{ tpl $port.name $root }}
  containerPort: {{ $port.containerPort }}
  protocol: {{ $port.protocol }}
    {{- with $port.hostPort }}
  hostPort: {{ . }}
    {{- end -}}
  {{- end -}}
{{- end -}}
