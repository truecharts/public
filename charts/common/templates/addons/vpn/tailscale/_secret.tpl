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
  {{- with .Values.addons.vpn.tailscale.authkey }}
  TS_AUTH_KEY: {{ . | b64enc }}
  {{- end }}
{{- end }}
