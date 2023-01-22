{{- define "tailscale.addon.persistence" -}}
enabled: true
mountPath: /var/lib/tailscale
type: emptyDir
noMount: true
{{- end -}}
