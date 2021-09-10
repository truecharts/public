{{/*
The OpenVPN sidecar container to be inserted.
*/}}
{{- define "common.addon.openvpn.container" -}}
name: openvpn
image: "{{ .Values.addons.vpn.openvpn.image.repository }}:{{ .Values.addons.vpn.openvpn.image.tag }}"
imagePullPolicy: {{ .Values.addons.vpn.openvpn.pullPolicy }}
{{- with .Values.addons.vpn.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.addons.vpn.env }}
env:
{{- range $k, $v := . }}
  - name: {{ $k }}
    value: {{ $v | quote }}
{{- end }}
{{- end }}
{{- if or .Values.addons.vpn.openvpn.auth .Values.addons.vpn.openvpn.authSecret }}
envFrom:
  - secretRef:
    {{- if .Values.addons.vpn.openvpn.authSecret }}
      name: {{ .Values.addons.vpn.openvpn.authSecret }}
    {{- else }}
      name: {{ include "common.names.fullname" . }}-openvpn
    {{- end }}
{{- end }}
{{- if or .Values.addons.vpn.configFile .Values.addons.vpn.scripts.up .Values.addons.vpn.scripts.down .Values.addons.vpn.additionalVolumeMounts .Values.persistence.shared.enabled }}
volumeMounts:
{{- if or .Values.addons.vpn.configFile }}
  - name: vpnconfig
    mountPath: /vpn/vpn.conf
    subPath: vpnConfigfile
{{- end }}
{{- if .Values.addons.vpn.scripts.up }}
  - name: vpnscript
    mountPath: /vpn/up.sh
    subPath: up.sh
{{- end }}
{{- if .Values.addons.vpn.scripts.down }}
  - name: vpnscript
    mountPath: /vpn/down.sh
    subPath: down.sh
{{- end }}
  - mountPath: {{ .Values.persistence.shared.mountPath }}
    name: shared
{{- with .Values.addons.vpn.livenessProbe }}
livenessProbe:
  {{- toYaml . | nindent 2 }}
{{- end -}}
{{- with .Values.addons.vpn.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
