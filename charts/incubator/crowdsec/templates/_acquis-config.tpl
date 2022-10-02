{{/* Define the configmap */}}
{{- define "crowdsec.acquis" -}}

{{- $configName := printf "%s-acquis-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  acquis.yaml: |-
    {{- $container_runtime := .Values.crowdsec.container_runtime }}
    {{- range .Values.crowdsec.acquisition.pods }}
    ---
    filenames:
      {{- if not .namespace }}
      - /var/log/containers/{{ .name }}_ix-{{ .name }}_*.log
      {{- else }}
      - /var/log/containers/{{ .name }}_{{ .namespace }}_*.log
      {{- end }}
    labels:
      type: {{ $container_runtime }}
      program: {{ .program }}
    {{- end }}

    {{- range .Values.crowdsec.acquisition.raw_log_paths }}
    ---
    filenames:
      - {{ .path }}
    labels:
      {{- with .type }}
      type: {{ . }}
      {{- end }}
      program: {{ .program }}
    {{- end }}
{{- end }}
