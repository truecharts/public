{{/* Define the configmap */}}
{{- define "crowdsec.config" -}}

{{- $acquisConfigName := printf "%s-acquis-config" (include "tc.common.names.fullname" .) }}
{{- $agentConfigName := printf "%s-agent-config" (include "tc.common.names.fullname" .) }}
{{- $lapiConfigName := printf "%s-lapi-config" (include "tc.common.names.fullname" .) }}
{{- $dashboardConfigName := printf "%s-dashboard-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $acquisConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  acquis.yaml: |-
    {{- $container_runtime := .Values.crowdsec.agent.container_runtime -}}
    {{- $acquisitionConfig := .Values.crowdsec.agent.acquisition -}}
    {{- range $acquisitionConfig.pods }}

    ---
    filenames:
      {{- if not .namespace }}
      - /var/log/containers/{{ .name }}_ix-{{ .name }}_*.log
      {{- else }}
      - /var/log/containers/{{ .name }}_{{ .namespace }}_*.log
      {{- end }}
    labels:
      type: {{ $container_runtime }}
      {{- with .program }}
      program: {{ . }}
      {{- end }}
    {{- end }}

    {{- range $acquisitionConfig.raw_log_paths }}
    ---
    filenames:
      - {{ .path }}
    labels:
      {{- with .type }}
      type: {{ . }}
      {{- end }}
      {{- with .program }}
      program: {{ . }}
      {{- end }}
    {{- end }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $agentConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  LOCAL_API_URL: {{ .Values.crowdsec.agent.local_api_url }}
  # Disable integrated LAPI. Use only the AGENT function
  DISABLE_LOCAL_API: "true"

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $lapiConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  # Disable integrated AGENT. Use only the LAPI function
  DISABLE_AGENT: "true"

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $dashboardConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  MB_DB_FILE: /metabase-data/metabase.db
{{- end }}
