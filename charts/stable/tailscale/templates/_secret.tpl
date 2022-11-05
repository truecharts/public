{{/* Define the secret */}}
{{- define "tailscale.secret" -}}

{{- $secretName := printf "%s-tailscale-secret" (include "tc.common.names.fullname" .) }}

---
{{/* This secrets are loaded on tailscale */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with .Values.tailscale.authkey }}
  {{/* Name of the authkey is crucial, don't change it */}}
  authkey: {{ . | b64enc }}
  {{- end }}
{{- end }}
