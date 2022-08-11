{{/* Define the secrets */}}
{{- define "tailscale.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: tailscale-auth
{{- $tailscaleauthprevious := lookup "v1" "Secret" .Release.Namespace "tailscale-auth" }}
{{- $authkey := "" }}
data:
  {{- if $tailscaleauthprevious}}
  SAUTHKEY: {{ index $tailscaleauthprevious.data "AUTHKEY" }}
  {{- else }}
  {{- $authkey := randAlphaNum 32 }}
  AUTHKEY: {{ $authkey | b64enc }}
  {{- end }}

{{- end -}}
