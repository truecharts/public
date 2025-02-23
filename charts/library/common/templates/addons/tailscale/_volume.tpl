

{{/*
The volume (referencing VPN config) to be inserted into persistence.
*/}}
{{- define "tc.v1.common.addon.tailscale.volume.config" -}}
{{/*{{- "/vpn" := (include "tc.v1.common.addon.tailscale.volume.basePath" .) }} */}}

{{- $mountPath := "/vpn" }}

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
{{- $mountPath = (printf "%s/vpn.conf" "/vpn") }}
type: hostPath
hostPath: {{ .Values.addons.vpn.configFile | default "/vpn" }}
hostPathType: "File"
autoPermissions:
  enabled: true
  chown: true
  user: 568
  group: 568
{{- end }}
targetSelector:
  {{- range .Values.addons.vpn.targetSelector }}
  {{ . }}:
    vpn:
      mountPath: {{ $mountPath }}
  {{- end -}}
{{- end -}}

{{/*
The volume (referencing VPN config folder) to be inserted into persistence.
*/}}
{{- define "tc.v1.common.addon.tailscale.volume.folder" -}}
{{/*{{- "/vpn" := (include "tc.v1.common.addon.tailscale.volume.basePath" .) }} */}}
enabled: true
type: hostPath
hostPath: {{ .Values.addons.vpn.configFolder | quote }}
autoPermissions:
  enabled: true
  chown: true
  user: 568
  group: 568
targetSelector:
  {{- range .Values.addons.vpn.targetSelector }}
  {{ . }}:
    vpn:
      mountPath: {{ "/vpn" }}
  {{- end -}}
{{- end -}}


{{/*
The empty tailscale folder
*/}}
{{- define "tc.v1.common.addon.tailscale.volume.tailscale" -}}
enabled: true
type: emptyDir
targetSelector:
  {{- range .Values.addons.vpn.targetSelector }}
  {{ . }}:
    tailscale:
      mountPath: /var/lib/tailscale
  {{- end -}}
{{- end -}}
