{{- define "wireguard.configfile" -}}
{{- if and .Values.wg.configFilePath ( not .Values.secret.enabled ) }}
enabled: true
type: hostPath
hostPathType: File
hostPath: {{ .Values.wg.configFilePath }}
mountPath: /etc/wireguard/wg0.conf
{{- end }}
{{- if .Values.secret.enabled }}
enabled: true
type: secret
readOnly: true
objectName: '{{ include "tc.common.names.fullname" . }}-wg-config-secret'
mountPath: /etc/wireguard
{{- end }}
{{- end -}}
