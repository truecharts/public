{{/*
The Wireguard sidecar container to be inserted.
*/}}
{{- define "tc.v1.common.addon.wireguard.container" -}}
imageSelector: wireguardImage
imagePullPolicy: {{ .Values.wireguardImage.pullPolicy }}
securityContext:
  runAsUser: 568
  runAsGroup: 568
  capabilities:
    add:
      - NET_ADMIN
      - SYS_MODULE
env:
  SEPARATOR: ";"
  IPTABLES_BACKEND: "nft"
{{- range $envList := .Values.addons.vpn.envList -}}
  {{- if and $envList.name $envList.value }}
  {{ $envList.name }}: {{ $envList.value | quote }}
  {{- else -}}
    {{- fail "Please specify name/value for VPN environment variable" -}}
  {{- end -}}
{{- end -}}

{{- with .Values.addons.vpn.env -}}
{{- range $k, $v := . }}
  {{ $k }}: {{ $v | quote }}
{{- end -}}
{{- end -}}

{{- if .Values.addons.vpn.killSwitch }}
  KILLSWITCH: "true"
  {{- $excludednetworksv4 := "172.16.0.0/12" -}}
  {{- range .Values.addons.vpn.excludedNetworks_IPv4 -}}
    {{- $excludednetworksv4 = (printf "%v;%v" $excludednetworksv4 .) -}}
  {{- end }}
  KILLSWITCH_EXCLUDEDNETWORKS_IPV4: {{ $excludednetworksv4 | quote }}
{{- if .Values.addons.vpn.excludedNetworks_IPv6 -}}
  {{- $excludednetworksv6 := "" -}}
  {{- range .Values.addons.vpn.excludedNetworks_IPv4 }}
    {{- $excludednetworksv6 =  (printf "%v;%v" $excludednetworksv6 .) -}}
  {{- end }}
  KILLSWITCH_EXCLUDEDNETWORKS_IPV6: {{ .Values.addons.vpn.excludedNetworks_IPv6 | quote }}
{{- end -}}
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
  inherit: true
{{- end -}}
{{- end -}}
