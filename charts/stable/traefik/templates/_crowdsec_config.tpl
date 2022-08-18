{{- define "crowdsec.agent.config" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-crowdsec-config
data:
  acquis.yaml: |-
    filenames:
    - "/var/log/traefik/*"
    labels:
      type: traefik
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-crowdsec-env
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with .Values.crowdsec.collections }}
  COLLECTIONS: "crowdsecurity/linux crowdsecurity/traefik"
  {{- end }}
  {{- with .Values.crowdsec.scenarios }}
  SCENARIOS: ""
  {{- end }}
  {{- with .Values.crowdsec.parsers }}
  PARSERS: ""
  {{- end }}
  {{- with .Values.crowdsec.traefik_bouncer_key }}
  BOUNCER_KEY_traefik: "supersecret"
  {{- end }}
{{- end -}}
