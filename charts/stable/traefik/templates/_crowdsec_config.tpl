{{- define "crowdsec.agent.config" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-crowdsec-env
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- if hasKey .Values.crowdsec "collections" }}
  COLLECTIONS: {{ .Values.crowdsec.collections | default "" }}
  {{- end }}
  {{- if hasKey .Values.crowdsec "scenarios" }}
  SCENARIOS: {{ .Values.crowdsec.scenarios | default "" }}
  {{- end }}
  {{- if hasKey .Values.crowdsec "parsers" }}
  PARSERS: {{ .Values.crowdsec.parsers | default "" }}
  {{- end }}
  {{- if hasKey .Values.crowdsec "traefik_bouncer_key" }}
  BOUNCER_KEY_traefik: {{ .Values.crowdsec.traefik_bouncer_key | default "" }}
  {{- end }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-crowdsec-config
data:
  acquis.yaml: |-
    filenames:
      {{- if hasKey .Values.crowdsec "logsPath" }}
    - "{{ .Values.crowdsec.logsPath | default "/var/log/traefik/*" }}"
      {{- end }}
    labels:
      type: traefik
{{- end -}}
