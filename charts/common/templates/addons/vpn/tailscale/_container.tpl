{{/*
The Tailscale sidecar container to be inserted.
*/}}
{{- define "tc.common.addon.tailscale.container" -}}
{{- $secretName := printf "%s-tailscale-secret" (include "tc.common.names.fullname" .) }}
name: tailscale
image: "{{ .Values.tailscaleImage.repository }}:{{ .Values.tailscaleImage.tag }}"
imagePullPolicy: {{ .Values.tailscaleImage.pullPolicy }}

command:
  - /usr/local/bin/containerboot

securityContext:
{{- if .Values.addons.vpn.tailscale.userspace }}
  runAsUser: 1000
  runAsGroup: 1000
  runAsNonRoot: true
  readOnlyRootFilesystem: true
{{- else }}
  runAsUser: 0
  runAsGroup: 0
  runAsNonRoot: false
  readOnlyRootFilesystem: false
{{- end }}
  capabilities:
    add:
      - NET_ADMIN

envFrom:
  - secretRef:
      name: {{ $secretName }}

env:
  - name: TS_SOCKET
    value: /var/run/tailscale/tailscaled.sock
  - name: TS_STATE_DIR
    value: /var/lib/tailscale
  - name: TS_AUTH_ONCE
    value: {{ .Values.addons.vpn.tailscale.auth_once | quote }}
  - name: TS_USERSPACE
    value: {{ .Values.addons.vpn.tailscale.userspace | quote }}
  - name: TS_ACCEPT_DNS
    value: {{ .Values.addons.vpn.tailscale.accept_dns | quote }}
    {{- with .Values.addons.vpn.tailscale.outbound_http_proxy_listen }}
  - name: TS_OUTBOUND_HTTP_PROXY_LISTEN
    value: {{ . }}
    {{- end }}
    {{- with .Values.addons.vpn.tailscale.routes }}
  - name: TS_ROUTES
    value: {{ . }}
    {{- end }}
    {{- with .Values.addons.vpn.tailscale.dest_ip }}
  - name: TS_DEST_IP
    value: {{ . }}
    {{- end }}
    {{- with .Values.addons.vpn.tailscale.sock5_server }}
  - name: TS_SOCKS5_SERVER
    value: {{ . }}
    {{- end }}
    {{- with .Values.addons.vpn.tailscale.extra_args }}
  - name: TS_EXTRA_ARGS
    value: {{ . | quote }}
    {{- end }}
    {{- with .Values.addons.vpn.tailscale.daemon_extra_args }}
  - name: TS_TAILSCALED_EXTRA_ARGS
    value: {{ . | quote }}
    {{- end }}

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

volumeMounts:
  - mountPath: {{ .Values.persistence.shared.mountPath }}
    name: shared
  - mountPath: /var/lib/tailscale
    name: {{ printf "%v-%v" .Release.Name "tailscale" }}
{{- with .Values.addons.vpn.livenessProbe }}
livenessProbe:
  {{- toYaml . | nindent 2 }}
{{- end -}}
{{- with .Values.addons.vpn.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
