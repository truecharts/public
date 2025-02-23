{{/*
The Tailscale sidecar container to be inserted.
*/}}
{{- define "tc.v1.common.addon.tailscale.containerModify" -}}
securityContext:
  {{- if $.Values.addons.vpn.tailscale.userspace }}
  runAsUser: 1000
  runAsGroup: 1000
  runAsNonRoot: false
  readOnlyRootFilesystem: true
  {{- else }}
  runAsUser: 0
  runAsGroup: 0
  runAsNonRoot: true
  readOnlyRootFilesystem: false
  {{- end }}

{{/*
Set KUBE_SECRET to empty string to force tailscale
to use the filesystem for state tracking.
With secret for state tracking you can't always
know if the app that uses this sidecard will
use a custom ServiceAccount and will lead to falure.
*/}}
env:
  TS_KUBE_SECRET: ""
  TS_SOCKET: /var/run/tailscale/tailscaled.sock
  TS_STATE_DIR: /var/lib/tailscale/state
  TS_AUTH_ONCE: {{ $.Values.addons.vpn.tailscale.auth_once | quote }}
  TS_USERSPACE: {{ $.Values.addons.vpn.tailscale.userspace | quote }}
  TS_ACCEPT_DNS: {{ $.Values.addons.vpn.tailscale.accept_dns | quote }}
  {{- with $.Values.addons.vpn.tailscale.outbound_http_proxy_listen }}
  TS_OUTBOUND_HTTP_PROXY_LISTEN: {{ . }}
  {{- end -}}
  {{- with $.Values.addons.vpn.tailscale.routes }}
  TS_ROUTES: {{ . }}
  {{- end -}}
  {{- with $.Values.addons.vpn.tailscale.dest_ip }}
  TS_DEST_IP: {{ . }}
  {{- end -}}
  {{- with $.Values.addons.vpn.tailscale.sock5_server }}
  TS_SOCKS5_SERVER: {{ . }}
  {{- end -}}
  {{- with $.Values.addons.vpn.tailscale.extra_args }}
  TS_EXTRA_ARGS: {{ . | quote }}
  {{- end -}}
  {{- with $.Values.addons.vpn.tailscale.daemon_extra_args }}
  TS_TAILSCALED_EXTRA_ARGS: {{ . | quote }}
  {{- end -}}
  {{- with $.Values.addons.vpn.tailscale.authkey }}
  TS_AUTH_KEY: {{ . }}
  {{- end }}
{{- end -}}
