{{/* Ports included by the container. */}}
{{- define "ix.v1.common.container.ports" -}}
  {{ $ports := list }}
  {{- range .Values.service -}}
    {{- if .enabled -}}
      {{- range $name, $port := .ports -}}
        {{- $_ := set $port "name" $name -}}
        {{- $ports = mustAppend $ports $port -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{/* Render the list of ports */}}
{{- if $ports }}
ports:
  {{- range $_ := $ports }}
    {{- if .enabled }}
  - name: {{ tpl .name $ }}
    {{- if and .targetPort (kindIs "string" .targetPort) }}
      {{- fail (printf "This common library does not support named ports for targetPort. (port name: %s, targetPort: %s)" .name .targetPort) }}
    {{- end }}
    {{- if not .port }}
      {{- fail (printf "Port is required on enabled services. Service: (%s)" .name) }}
    {{- end }}
    containerPort: {{ default .port .targetPort }}
    {{- with .protocol }}
    {{- if or (eq (. | upper) "HTTP") (eq (. | upper) "HTTPS") (eq (. | upper) "TCP") }}
    protocol: TCP
    {{- else if (eq (. | upper) "UDP") }}
    protocol: {{ . }}
    {{- else }}
      {{- fail (printf "Not valid <protocol> (protocl: %s)" .) }}
    {{- end }}
    {{- else }} {{/* If no protocol is given, default to TCP */}}
    protocol: TCP
    {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}
{{- end -}}

{{/*
If no targetPort is given, default to port.
This is for cases where port (that container listens)
can be dynamically configured via an env var.
*/}}
