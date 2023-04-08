{{/* Define the secret */}}
{{- define "tailscale.config" -}}

{{- $customArgs := "" -}}
{{- $secretName := (printf "%s-tailscale-secret" (include "tc.v1.common.lib.chart.names.fullname" .)) -}}
{{- if .Values.tailscale.hostname }}
  {{- $customArgs = (printf "--hostname %v %v" .Values.tailscale.hostname $customArgs | trim) -}}
{{- end }}

{{- if .Values.tailscale.advertise_as_exit_node }}
  {{- $customArgs = (printf "--advertise-exit-node %v" $customArgs | trim) -}}
{{- end }}

{{- if .Values.tailscale.extra_args }}
  {{- $customArgs = (printf "%v %v" .Values.tailscale.extra_args $customArgs | trim) -}}
{{- end }}
enabled: true
data:
  TS_KUBE_SECRET: {{ $secretName | squote }}
  TS_SOCKET: /var/run/tailscale/tailscaled.sock
  TS_USERSPACE: {{ .Values.tailscale.userspace | quote }}
  TS_ACCEPT_DNS: {{ .Values.tailscale.accept_dns | quote }}
  TS_AUTH_ONCE: {{ .Values.tailscale.auth_once | quote }}
  {{- with .Values.tailscale.routes }}
  TS_ROUTES: {{ . }}
  {{- end }}
  {{- with .Values.tailscale.dest_ip }}
  TS_DEST_IP: {{ . }}
  {{- end }}
  {{- with .Values.tailscale.sock5_server }}
  TS_SOCK5_SERVER: {{ . }}
  {{- end }}
  {{- with .Values.tailscale.daemon_extra_args }}
  TS_TAILSCALED_EXTRA_ARGS: {{ . | quote }}
  {{- end }}
  {{- with $customArgs }}
  TS_EXTRA_ARGS: {{ . | quote }}
  {{- end }}
  {{- with .Values.tailscale.outbound_http_proxy_listen }}
  TS_OUTBOUND_HTTP_PROXY_LISTEN: {{ . | quote }}
  {{- end }}
{{- end }}
