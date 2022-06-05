{{/*
Ports included by the controller.
*/}}
{{- define "tc.common.controller.ports" -}}
  {{- $ports := list -}}
  {{- range .Values.service -}}
    {{- if .enabled -}}
      {{- range $name, $port := .ports -}}
        {{- $_ := set $port "name" $name -}}
        {{- $ports = mustAppend $ports $port -}}
      {{- end }}
    {{- end }}
  {{- end }}

{{/* export/render the list of ports */}}
{{- if $ports -}}
{{- range $_ := $ports }}
{{- if .enabled }}
- name: {{ tpl .name $ }}
  {{- if and .targetPort (kindIs "string" .targetPort) }}
  {{- fail (printf "Our charts do not support named ports for targetPort. (port name %s, targetPort %s)" .name .targetPort) }}
  {{- end }}
  containerPort: {{ .targetPort | default .port }}
  {{- if .protocol }}
  {{- if or ( eq .protocol "HTTP" ) ( eq .protocol "HTTPS" ) ( eq .protocol "TCP" ) }}
  protocol: TCP
  {{- else }}
  protocol: {{ tpl .protocol $ }}
  {{- end }}
  {{- else }}
  protocol: TCP
  {{- end }}
{{- end}}
{{- end -}}
{{- end -}}
{{- end -}}
