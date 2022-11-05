{{- define "tailscale.addon.persistence" -}}
enabled: true
mountPath: /var/lib/tailscale
size: 1Gi
noMount: true
{{- end -}}
