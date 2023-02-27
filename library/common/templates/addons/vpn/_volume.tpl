{{/*
The volume (referencing VPN scripts) to be inserted into persistence.
*/}}
{{- define "tc.v1.common.addon.vpn.volume.scripts" -}}
enabled: true
type: configmap
objectName: vpnscripts
expandObjectName: false
defaultMode: "0777"
items:
{{- if .Values.addons.vpn.scripts.up }}
- key: up.sh
  path: up.sh
{{- end -}}
{{- if .Values.addons.vpn.scripts.down }}
- key: down.sh
  path: down.sh
{{- end }}
targetSelector:
  {{- range .Values.addons.vpn.targetSelector }}
  {{ . }}:
    vpn:
      mountPath: /vpn
  {{- end -}}
{{- end -}}


{{/*
The volume (referencing VPN config) to be inserted into persistence.
*/}}
{{- define "tc.v1.common.addon.vpn.volume.config" -}}
enabled: true
{{- if or .Values.addons.vpn.config .Values.addons.vpn.existingSecret }}
type: secret
defaultMode: "0777"
items:
  - key: vpn.conf
    path: vpn.conf

{{- if .Values.addons.vpn.existingSecret }}
objectName: {{ .Values.addons.vpn.existingSecret }}
expandObjectName: false
{{- else }}
objectName: vpnconfig
expandObjectName: true
{{- end -}}
{{- else }}

type: hostPath
hostPath: {{ .Values.addons.vpn.configFile | default "/vpn" }}
hostPathType: "File"
{{- end }}
targetSelector:
  {{- range .Values.addons.vpn.targetSelector }}
  {{ . }}:
    vpn:
      mountPath: /vpn
  {{- end -}}
{{- end -}}

{{/*
The volume (referencing VPN config folder) to be inserted into persistence.
*/}}
{{- define "tc.v1.common.addon.vpn.volume.folder" -}}
enabled: true
type: hostPath
hostPath: {{ .Values.addons.vpn.configFolder | quote }}
targetSelector:
  {{- range .Values.addons.vpn.targetSelector }}
  {{ . }}:
    vpn:
      mountPath: /vpn
  {{- end -}}
{{- end -}}


{{/*
The empty tailscale folder
*/}}
{{- define "tc.v1.common.addon.vpn.volume.tailscale" -}}
enabled: true
type: emptyDir
targetSelector:
  {{- range .Values.addons.vpn.targetSelector }}
  {{ . }}:
    tailscale:
      mountPath: /var/lib/tailscale
  {{- end -}}
{{- end -}}
