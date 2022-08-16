{{/* Define the configmap */}}
{{- define "tailscale.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-start
data:
  start.sh: |-
    #!/bin/ash
    # Not a typo. It's 'ash', not 'bash'
    echo "Starting Tailscale Daemon"
    tailscaled &
    sleep 3
    echo "Connecting to network"
    {{- if .Values.tailscale.override }}
    tailscale {{ .Values.tailscale.command }} {{ .Values.tailscale.args }}
    {{- else }}
    {{- with .Values.tailscale.authkey }}
    tailscale up --authkey={{ . }}
    {{- end }}
    {{- end }}

    tailscale status
    sleep infinity
{{- end -}}
