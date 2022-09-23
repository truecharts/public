{{- define "portainer.args" -}}
args:
  - --tunnel-port={{ .Values.service.edge.ports.edge.port }}
  - --http-disabled
  {{- with .Values.portainer.logo }}
  --logo={{ . }}
  {{- end }}
{{- end -}}
