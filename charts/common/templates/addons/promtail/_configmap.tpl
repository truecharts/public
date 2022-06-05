{{/*
The promtail config to be included.
*/}}
{{- define "tc.common.addon.promtail.configmap" -}}
{{- if .Values.addons.promtail.enabled }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-promtail
  labels:
  {{- include "tc.common.labels" . | nindent 4 }}
data:
  promtail.yaml: |
    server:
      http_listen_port: 9080
      grpc_listen_port: 0
    positions:
      filename: /tmp/positions.yaml
    {{- with .Values.addons.promtail.loki }}
    client:
      url: {{ . }}
    {{- end }}
    scrape_configs:
    {{- range .Values.addons.promtail.logs }}
    - job_name: {{ .name }}
      static_configs:
      - targets:
          - localhost
        labels:
          job: {{ .name }}
          __path__: "{{ .path }}"
    {{- end }}
{{- end -}}
{{- end -}}
