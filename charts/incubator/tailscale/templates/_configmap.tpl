{{/* Define the secret */}}
{{- define "tailscale.config" -}}

{{- $configName := printf "%s-tailscale-config" (include "tc.common.names.fullname" .) }}

---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $ldapConfigName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  TS_KUBE_SECRET: {{ printf "%s-tailscale-secret" (include "tc.common.names.fullname" .) }}
  TS_USERSPACE: {{ .Values.tailscale.userSpace | quote }}
  TS_ACCEPT_DNS: {{ .Values.tailscale.acceptDNS | quote }}
  {{- with .Values.tailscale.routes }}
  TS_ROUTES: {{ .Values.tailscale.routes }}
  {{- end }}
  {{- with .Values.tailscale.dest_ip }}
  TS_DEST_IP: {{ .Values.tailscale.dest_ip }}
  {{- end }}
  {{- with .Values.tailscale.extra_args }}
  TS_EXTRA_ARGS: {{ .Values.tailscale.extra_args }}
  {{- end }}
{{- end }}
