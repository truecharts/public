{{/* Define the secret */}}
{{- define "tailscale.secret" -}}

{{- $secretName := printf "%s-tailscale-secret" (include "ix.v1.common.names.fullname" .) }}

---
{{/* This secrets are loaded on tailscale */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
data:
  {{- with .Values.addons.vpn.tailscale.authkey }}
  TS_AUTH_KEY: {{ . | b64enc }}
  {{- end }}
{{- end }}
