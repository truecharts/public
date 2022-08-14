{{- define "crowdsec.agent.config" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-crowdsec-env
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with .Values.crowdsec.collections }}
  COLLECTIONS: {{ . | default "" }}
  {{- end }}
  {{- with .Values.crowdsec.scenarios }}
  SCENARIOS: {{ . | default "" }}
  {{- end }}
  {{- with .Values.crowdsec.parsers }}
  PARSERS: {{ . | default "" }}
  {{- end }}
  {{- with .Values.crowdsec.traefik_bouncer_key }}
  BOUNCER_KEY_traefik: {{ . | default "" }}
  {{- end }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-crowdsec-config
data:
  acquis.yaml: |-
    filenames:
    - "{{ .Values.crowdsec.logsPath }}"
    labels:
      type: traefik
{{- end -}}
