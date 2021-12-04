{{/*
Render all the ports and additionalPorts for a Service object.
*/}}
{{- define "common.classes.service.ports" -}}
  {{- $values := .values -}}
  {{- $ports := $values.ports -}}
  {{- if $ports -}}
  ports:
  {{- range $_ := $ports }}
  - port: {{ .port }}
    targetPort: {{ .targetPort | default "http" }}
    protocol: {{ .protocol | default "TCP" }}
    name: {{ .name | default "http" }}
    {{- if (and (eq $.svcType "NodePort") (not (empty .nodePort))) }}
    nodePort: {{ .nodePort }}
    {{ end }}
  {{- end -}}
  {{- end -}}
{{- end }}
