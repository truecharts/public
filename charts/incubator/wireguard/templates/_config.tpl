{{- define "wireguard.configfile" -}}
enabled: true
type: hostPath
hostPathType: File
hostPath: {{ .Values.env.CONFIG_FILE_PATH }}
{{- end -}}
