{{/* Define the secrets */}}
{{- define "openproject.secrets" -}}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: openproject-secrets
{{- $openprojectprevious := lookup "v1" "Secret" .Release.Namespace "openproject-secrets" }}
{{- $secret_key_base := "" }}
data:
  {{- if $openprojectprevious}}
  SECRET_KEY_BASE: {{ index $openprojectprevious.data "SECRET_KEY_BASE" }}
  {{- else }}
  {{- $secret_key_base := randAlphaNum 32 }}
  SECRET_KEY_BASE: {{ $secret_key_base | b64enc }}
  {{- end }}

{{- end -}}
