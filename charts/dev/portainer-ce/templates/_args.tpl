{{- define "portainer.args" -}}
args:
  - --tunnel-port={{ .Values.service.edge.ports.edge.port }}
  - --http-disabled
  {{- with .Values.portainer.logo }}
  - --logo={{ . }}
  {{- end }}
  {{- if .Values.portainer.edge_compute }}
  - --edge-compute
  {{- end }}
  {{- with .Values.portainer.snapshot_interval }}
  - --snapshot-interval={{ . }}
  {{- end }}
  {{- if .Values.portainer.hide_labels }}
  {{- range .Values.portainer.hide_labels }}
  - --hide-label={{ . }}
  {{- end }}
  {{- end }}
{{- end -}}
