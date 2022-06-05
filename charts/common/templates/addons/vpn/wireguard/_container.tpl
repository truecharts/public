{{/*
The Wireguard sidecar container to be inserted.
*/}}
{{- define "tc.common.addon.wireguard.container" -}}
name: wireguard
image: "{{ .Values.wireguardImage.repository }}:{{ .Values.wireguardImage.tag }}"
imagePullPolicy: {{ .Values.wireguardImage.pullPolicy }}
securityContext:
  runAsUser: 568
  runAsGroup: 568
  capabilities:
    add:
      - NET_ADMIN
      - SYS_MODULE
env:
  - name: SEPARATOR
    value: ";"
  - name: IPTABLES_BACKEND
    value: "nft"
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
  - name: KILLSWITCH
    value: "true"
  {{- $excludednetworksv4 := "172.16.0.0/12"}}
  {{- range .Values.addons.vpn.excludedNetworks_IPv4 }}
    {{- $excludednetworksv4 =  ( printf "%v;%v" $excludednetworksv4 . ) }}
  {{- end}}
  - name: KILLSWITCH_EXCLUDEDNETWORKS_IPV4
    value: {{ $excludednetworksv4 | quote }}
{{- if .Values.addons.vpn.excludedNetworks_IPv6 }}
  {{- $excludednetworksv6 := ""}}
  {{- range .Values.addons.vpn.excludedNetworks_IPv4 }}
    {{- $excludednetworksv6 =  ( printf "%v;%v" $excludednetworksv6 . ) }}
  {{- end}}
  - name: KILLSWITCH_EXCLUDEDNETWORKS_IPV6
    value: {{ .Values.addons.vpn.excludedNetworks_IPv6 | quote }}
{{- end }}
{{- end }}

volumeMounts:
  - mountPath: {{ .Values.persistence.shared.mountPath }}
    name: shared
{{- if .Values.addons.vpn.configFile }}
  - name: vpnconfig
    mountPath: /etc/wireguard/wg0.conf
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
