{{- define "kasm.udev.mount" -}}
enabled: true
type: hostPath
mountPath: /run/udev/data
hostPath: /run/udev/data
{{- end -}}

{{- define "kasm.input.mount" -}}
enabled: true
type: hostPath
mountPath: /dev/input
hostPath: /dev/input
{{- end -}}
