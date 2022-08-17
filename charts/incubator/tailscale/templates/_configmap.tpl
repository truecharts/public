{{/* Define the secret */}}
{{- define "tailscale.config" -}}

{{- $configName := printf "%s-tailscale-config" (include "tc.common.names.fullname" .) }}
{{- $secretName := printf "%s-tailscale-secret" (include "tc.common.names.fullname" .) }}

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  TS_KUBE_SECRET: {{ $secretName | squote }}
  TS_USERSPACE: {{ .Values.tailscale.userspace | quote }}
  TS_ACCEPT_DNS: {{ .Values.tailscale.accept_dns | quote }}
  {{- with .Values.tailscale.routes }}
  TS_ROUTES: {{ . }}
  {{- end }}
  {{- with .Values.tailscale.dest_ip }}
  TS_DEST_IP: {{ . }}
  {{- end }}
  {{- with .Values.tailscale.sock5_server }}
  TS_SOCK5_SERVER: {{ . }}
  {{- end }}
  {{- with .Values.tailscale.extra_args }}
  TS_EXTRA_ARGS: {{ . | quote }}
  {{- end }}
{{- end }}
