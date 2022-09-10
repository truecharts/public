{{/* Mount the hostPath whitelist if defined else mount the 'blockyWhitelist' list as configMap */}}
{{- define "blocky.whitelist" -}}
{{- if .Values.blocky.whitelistPath }}
enabled: true
type: hostPath
readOnly: true
hostPathType: File
hostPath: {{ .Values.blocky.whitelistPath }}
mountPath: /app/whitelists/whitelist.txt
{{- else }}
enabled: true
type: custom
mountPath: /app/whitelists/whitelist.txt
subPath: whitelist.txt
readOnly: true
volumeSpec:
  configMap:
    name: '{{ printf "%s-config" (include "tc.common.names.fullname" .) }}'
{{- end }}
{{- end -}}

{{/* Mount the hostPath blacklist if defined else mount the 'blockyBlacklist' list as configMap */}}
{{- define "blocky.blacklist" -}}
{{- if .Values.blocky.blacklistPath }}
enabled: true
type: hostPath
readOnly: true
hostPathType: File
hostPath: {{ .Values.blocky.blacklistPath }}
mountPath: /app/blacklists/blacklist.txt
{{- else }}
enabled: true
type: custom
mountPath: /app/blacklists/blacklist.txt
subPath: blacklist.txt
readOnly: true
volumeSpec:
  configMap:
    name: '{{ printf "%s-config" (include "tc.common.names.fullname" .) }}'
{{- end }}
{{- end -}}

{{/* Always mount the configmap, with the basic config, plus the 'blockyConfig' */}}
{{- define "blocky.configmap.mount" -}}
enabled: true
type: custom
mountPath: /app/tc/tc-config.yaml
subPath: tc-config.yaml
readOnly: true
volumeSpec:
  configMap:
    name: '{{ printf "%s-config" (include "tc.common.names.fullname" .) }}'
{{- end -}}

{{/* Mount the hostPath file if defined */}}
{{- define "blocky.config" -}}
{{- if .Values.blocky.configPath }}
enabled: true
type: hostPath
readOnly: true
hostPathType: File
hostPath: {{ .Values.blocky.configPath }}
mountPath: /app/tc/hostPath-config.yaml
{{- end }}
{{- end -}}
