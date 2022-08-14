{{- define "crowdsec.agent.config" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-crowdsec-env
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  COLLECTIONS: {{ .Values.crowdsec.collections | default "" }}
  SCENARIOS: {{ .Values.crowdsec.scenarios | default "" }}
  PARSERS: {{ .Values.crowdsec.parsers | default "" }}
  BOUNCER_KEY_traefik: {{ .Values.crowdsec.traefik_bouncer_key | default "" }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-crowdsec-config
data:
  acquis.yaml: |-
    filenames:
    - "{{ .Values.crowdsec.logsPath | default "/var/log/traefik/*" }}"
    labels:
      type: traefik
{{- end -}}
