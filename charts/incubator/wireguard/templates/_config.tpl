{{- define "wireguard.configfile" -}}
enabled: true
type: hostPath
hostPathType: File
hostPath: {{ .Values.env.CONFIG_FILE_PATH }}
mountPath: /etc/wireguard/wg0.conf
{{- end -}}
