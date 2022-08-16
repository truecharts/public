{{/* Define the configmap */}}
{{- define "tailscale.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-start
data:
  start.sh: |-
    #!/bin/sh
    echo "Starting Tailscale Daemon"
    tailscaled &
    sleep 3
    echo "Connecting to network"
    tailsacle up --authkey={{ .Values.tailscale.authkey }}

    tailscale status
    sleep infinity
{{- end -}}
