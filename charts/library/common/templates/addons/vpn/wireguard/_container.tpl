{{/*
The Wireguard sidecar container to be inserted.
*/}}
{{- define "common.addon.wireguard.container" -}}
name: wireguard
image: "{{ .Values.wireguardImage.repository }}:{{ .Values.wireguardImage.tag }}"
imagePullPolicy: {{ .Values.wireguardImage.pullPolicy }}
securityContext:
  runAsUser: 568
  runAsGroup: 568
  fsGroup: 568
  capabilities:
    add:
      - NET_ADMIN
      - SYS_MODULE
{{- with .Values.addons.vpn.securityContext }}
  {{- toYaml . | nindent 2 }}
{{- end }}
env:
{{- range $envList := .Values.addons.vpn.envList }}
  {{- if and $envList.name $envList.value }}
  - name: {{ $envList.name }}
    value: {{ $envList.value | quote }}
  {{- else }}
  {{- fail "Please specify name/value for VPN environment variable" }}
  {{- end }}
{{- end}}
{{- with .Values.addons.vpn.env }}
{{- range $k, $v := . }}
  - name: {{ $k }}
    value: {{ $v | quote }}
{{- end }}
  - name: SEPARATOR
    value: ";"
{{- if .Values.addons.vpn.wireguard.KILLSWITCH }}
  - name: KILLSWITCH
    value: "true"
{{- if .Values.addons.vpn.wireguard.KILLSWITCH_EXCLUDEDNETWORKS_IPV4 }}
  - name: KILLSWITCH_EXCLUDEDNETWORKS_IPV4
    value: {{ .Values.addons.vpn.wireguard.KILLSWITCH_EXCLUDEDNETWORKS_IPV4 | quote }}
{{- end }}
{{- if .Values.addons.vpn.wireguard.KILLSWITCH_EXCLUDEDNETWORKS_IPV6 }}
  - name: KILLSWITCH_EXCLUDEDNETWORKS_IPV4
    value: {{ .Values.addons.vpn.wireguard.KILLSWITCH_EXCLUDEDNETWORKS_IPV6 | quote }}
{{- end }}
{{- end }}

{{- end }}
{{- if or .Values.addons.vpn.configFile .Values.addons.vpn.scripts.up .Values.addons.vpn.scripts.down .Values.addons.vpn.additionalVolumeMounts .Values.persistence.shared.enabled }}
volumeMounts:
{{- if or .Values.addons.vpn.configFile }}
  - name: vpnconfig
    mountPath: /etc/wireguard/wg0.conf
    subPath: vpnConfigfile
{{- end }}
{{- if .Values.addons.vpn.scripts.up }}
  - name: vpnscript
    mountPath: /config/up.sh
    subPath: up.sh
{{- end }}
{{- if .Values.addons.vpn.scripts.down }}
  - name: vpnscript
    mountPath: /config/down.sh
    subPath: down.sh
{{- end }}
  - mountPath: {{ .Values.persistence.shared.mountPath }}
    name: shared
{{- end }}
{{- with .Values.addons.vpn.livenessProbe }}
livenessProbe:
  {{- toYaml . | nindent 2 }}
{{- end -}}
{{- with .Values.addons.vpn.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
