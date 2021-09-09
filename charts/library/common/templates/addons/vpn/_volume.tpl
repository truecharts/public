{{/*
The volume (referencing VPN scripts) to be inserted into additionalVolumes.
*/}}
{{- define "common.addon.vpn.scriptsVolumeSpec" -}}
{{- if or .Values.addons.vpn.scripts.up .Values.addons.vpn.scripts.down -}}
configMap:
  name: {{ include "common.names.fullname" . }}-vpn
  items:
    {{- if .Values.addons.vpn.scripts.up }}
    - key: up.sh
      path: up.sh
      mode: 0777
    {{- end }}
    {{- if .Values.addons.vpn.scripts.down }}
    - key: down.sh
      path: down.sh
      mode: 0777
    {{- end }}
{{- end -}}
{{- end -}}

{{/*
The volume (referencing VPN config) to be inserted into additionalVolumes.
*/}}
{{- define "common.addon.vpn.configVolumeSpec" -}}
{{- if or .Values.addons.vpn.configFile .Values.addons.vpn.configFileSecret -}}
secret:
  {{- if .Values.addons.vpn.configFileSecret }}
  secretName: {{ .Values.addons.vpn.configFileSecret }}
  {{- else }}
  secretName: {{ include "common.names.fullname" . }}-vpnconfig
  {{- end }}
  items:
    - key: vpnConfigfile
      path: vpnConfigfile
{{- end -}}
{{- end -}}
