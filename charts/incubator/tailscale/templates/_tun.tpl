{{- define "tailscale.tun" -}}
---
enabled: true
type: hostPath
hostPath: /dev/net/tun
mountPath: /dev/net/tun
hostPathType: ""
readOnly: false
{{- end }}
