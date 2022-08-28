{{- define "wireguard.configfile" -}}
{{- if and .Values.wg.configFilePath ( not .Values.secret.enabled ) }}
enabled: true
type: hostPath
hostPathType: File
hostPath: {{ .Values.wg.configFilePath }}
mountPath: /etc/wireguard/wg0.conf
defaultMode: 755
{{- end }}
{{- if .Values.secret.enabled }}
enabled: true
type: "custom"
readOnly: true
mountPath: /etc/wireguard/wg0.conf
subPath: "wg0.conf"
defaultMode: 755
volumeSpec:
  secret:
    secretName: "wg-config-secret"
{{- end }}
{{- end -}}
