{{/* Define the secret */}}
{{- define "crowdsec.secret" -}}

{{- $credsSecretName := printf "%s-credentials-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $credsSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  AGENT_USERNAME: {{ required "You must provide a username" .Values.crowdsec.credentials.username | b64enc }}
  AGENT_PASSWORD: {{ required "You must provide a password" .Values.crowdsec.credentials.password | b64enc }}
{{- end }}
