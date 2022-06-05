{{/*
The OpenVPN sidecar container to be inserted.
*/}}
{{- define "tc.common.addon.openvpn.container" -}}
name: openvpn
image: "{{ .Values.openvpnImage.repository }}:{{ .Values.openvpnImage.tag }}"
imagePullPolicy: {{ .Values.openvpnImage.pullPolicy }}
securityContext:
  runAsUser: 0
  runAsGroup: 0
  capabilities:
    add:
      - NET_ADMIN
      - SYS_MODULE
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
{{- end }}

{{- if .Values.addons.vpn.killSwitch }}
  - name: FIREWALL
    value: "ON"
  - name: ROUTE_1
    value: "172.16.0.0/12"
  {{- range $index, $value := .Values.addons.vpn.excludedNetworks_IPv4 }}
  - name: ROUTE_{{ add $index 2 }}
    value: {{ $value | quote }}
  {{- end}}
{{- if .Values.addons.vpn.excludedNetworks_IPv6 }}
  {{- $excludednetworksv6 := ""}}
  {{- range .Values.addons.vpn.excludedNetworks_IPv4 }}
    {{- $excludednetworksv6 =  ( printf "%v;%v" $excludednetworksv6 . ) }}
  {{- end}}
  {{- range $index, $value := .Values.addons.vpn.excludedNetworks_IPv6 }}
  - name: ROUTE6_{{ add $index 1 }}
    value: {{ $value | quote }}
  {{- end}}
{{- end }}
{{- end }}

{{- if or ( .Values.addons.vpn.openvpn.username ) ( .Values.addons.vpn.openvpn.password ) }}
envFrom:
  - secretRef:
      name: {{ include "tc.common.names.fullname" . }}-openvpn
{{- end }}
volumeMounts:
  - mountPath: {{ .Values.persistence.shared.mountPath }}
    name: shared
{{- if .Values.addons.vpn.configFile }}
  - name: vpnconfig
    mountPath: /vpn/vpn.conf
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
