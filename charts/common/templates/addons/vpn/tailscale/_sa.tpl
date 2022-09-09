{{- define "tailscale.sa" -}}

{{- $saName := printf "%s-tailscale-addon" (include "tc.common.names.fullname" .) -}}

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ $saName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
  annotations:
  {{- with .Values.addons.vpn.tailscale.annotations }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
{{- end -}}
