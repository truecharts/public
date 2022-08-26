{{- define "wireguard.configfile" -}}
enabled: true
type: hostPath
noMount: true
hostPathType: File
hostPath: {{ .Values.env.CONFIG_FILE_PATH }}
{{- end -}}
