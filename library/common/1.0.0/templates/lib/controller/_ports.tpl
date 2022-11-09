{{/*
Ports included in the controller.
*/}}
{{- define "ix.v1.common.controller.ports" -}}
  {{ $ports := list }}
  {{- range .Values.service -}}
    {{- if .enabled -}}
      {{- range $name, $port := .ports -}}
        {{- $_ := set $port "name" $name -}}
        {{- $ports = mustAppend $ports $port -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}


{{/*
Render the list of ports
*/}}
{{- if $ports -}}
{{- range $_ := $ports }}
  {{- if .enabled }}
- name: {{ tpl .name $ }}
  {{- if and .targetPort (kindIs "string" .targetPort) }}
    {{- fail (printf "This common library does not support named ports for targetPort. (port name: %s, targetPort: %s)" .name .targetPort) }}
  {{- end }}
  {{/*
  If no targetPort is given, default to port.
  This is for cases where port (that container listens)
  can be dynamically configured via an env var.
  */}}
  containerPort: {{ default .port .targetPort }}
  {{- with .protocol }}
  {{- if or (eq (. | upper) "HTTP") (eq (. | upper) "HTTPS") (eq (. | upper) "TCP") }}
  protocol: TCP
  {{- else if (eq (. | upper) "UDP") }}
  protocol: {{ . }}
  {{- else }}
    {{- fail (printf "Not valid <protocol> (protocl: %s)" .) }}
  {{- end }}
  {{/* If no protocol is given, default to TCP */}}
  {{- else }}
  protocol: TCP
  {{- end }}
  {{- end }}
{{- end }}
{{- end -}}
{{- end -}}
