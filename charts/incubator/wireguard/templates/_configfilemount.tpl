{{- define "wireguard.configfile" -}}
{{- if and .Values.wg.configFilePath ( not .Values.wg.config.enable ) }}
enabled: true
type: hostPath
readOnly: true
defaultMode: 0600
hostPathType: File
hostPath: {{ .Values.wg.configFilePath }}
mountPath: /etc/wireguard/wg0.conf
{{- end }}
{{- if .Values.wg.config.enabled }}
enabled: true
type: secret
readOnly: true
defaultMode: 0600
objectName: '{{ printf "%s-wg-config-secret" (include "tc.common.names.fullname" .) }}'
mountPath: /etc/wireguard
items:
  - key: wg0.conf
    path: wg0.conf
{{- end }}
{{- end -}}
