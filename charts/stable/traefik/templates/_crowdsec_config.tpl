{{- define "crowdsec.agent.config" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-crowdsec-config
data:
  acquis.yaml: |-
    filenames:
    - somevalue
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
  {{- with .Values.crowdsec.collections | quote }}
  COLLECTIONS: somevalue
  {{- end }}
  {{- with .Values.crowdsec.scenarios }}
  SCENARIOS: somevalue
  {{- end }}
  {{- with .Values.crowdsec.parsers }}
  PARSERS: somevalue
  {{- end }}
  {{- with .Values.crowdsec.traefik_bouncer_key | squote }}
  BOUNCER_KEY_traefik: somevalue
  {{- end }}
{{- end -}}
